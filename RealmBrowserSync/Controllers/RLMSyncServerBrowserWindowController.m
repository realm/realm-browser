////////////////////////////////////////////////////////////////////////////
//
// Copyright 2016 Realm Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
////////////////////////////////////////////////////////////////////////////

@import Realm.Dynamic;
@import Realm.Private;

#import "RLMSyncServerBrowserWindowController.h"

static NSString * const RLMAdminRealmServerPath = @"__admin";
static NSString * const RLMAdminRealmRealmFileClassName = @"RealmFile";
static NSString * const RLMAdminRealmRealmFilesDefaultPredicate = @"(path != '/__admin') AND \
                                                                     NOT (path ENDSWITH '__permission') AND \
                                                                     NOT (path ENDSWITH '__management')";

@interface RLMSyncServerBrowserWindowController ()<NSSearchFieldDelegate, NSTableViewDataSource, NSTableViewDelegate>

@property (nonatomic, weak) IBOutlet NSTextField *titleLabel;
@property (nonatomic, weak) IBOutlet NSSearchField *searchField;
@property (nonatomic, weak) IBOutlet NSProgressIndicator *progressIndicator;
@property (nonatomic, weak) IBOutlet NSTableView *tableView;

@property (nonatomic, strong) NSURL *serverURL;
@property (nonatomic, strong) RLMSyncUser *user;
@property (nonatomic, strong) RLMNotificationToken *notificationToken;

@property (nonatomic, strong) RLMResults *serverRealmFiles;
@property (nonatomic, strong) RLMResults *filteredServerRealmFiles;
@property (nonatomic, strong) NSURL *selectedURL;

@end

@implementation RLMSyncServerBrowserWindowController

- (instancetype)initWithServerURL:(NSURL *)serverURL user:(RLMSyncUser *)user {
    self = [super init];

    if (self != nil) {
        self.serverURL = serverURL;
        self.user = user;
    }

    return self;
}

- (void)dealloc {
    [self.notificationToken invalidate];
}

- (void)windowDidLoad {
    [super windowDidLoad];

    if ([self.window respondsToSelector:@selector(titleVisibility)]) {
        self.window.titleVisibility = NSWindowTitleHidden;
    }

    self.titleLabel.stringValue = self.serverURL.absoluteString;
    self.tableView.target = self;
    self.tableView.doubleAction = @selector(tableViewDoubleAction:);
    self.tableView.hidden = YES;
    self.searchField.enabled = NO;
}

- (void)showWindow:(id)sender {
    [super showWindow:sender];

    NSURL *adminRealmURL = [self.serverURL URLByAppendingPathComponent:RLMAdminRealmServerPath];

    RLMRealmConfiguration *configuration = [[RLMRealmConfiguration alloc] init];
    configuration.dynamic = YES;
    configuration.syncConfiguration = [[RLMSyncConfiguration alloc] initWithUser:self.user realmURL:adminRealmURL];
    configuration.syncConfiguration.enableSSLValidation = NO;

    __weak typeof(self) weakSelf = self;
    [RLMRealm asyncOpenWithConfiguration:configuration callbackQueue:dispatch_get_main_queue() callback:^(RLMRealm *realm, NSError *error) {
        if (!weakSelf || !weakSelf.window.isVisible) {
            // A window has been closed before realm is loaded
            return;
        } else if (error) {
            [[NSAlert alertWithError:error] beginSheetModalForWindow:weakSelf.window completionHandler:^(NSModalResponse returnCode) {
                [weakSelf close];
            }];
        } else {
            [weakSelf didOpenAdminRealm:realm];
        }
    }];

    [self.progressIndicator startAnimation:nil];
}

- (void)didOpenAdminRealm:(RLMRealm *)realm {
    self.serverRealmFiles = [realm objects:RLMAdminRealmRealmFileClassName where:RLMAdminRealmRealmFilesDefaultPredicate];
    self.filteredServerRealmFiles = self.serverRealmFiles;

    __weak typeof(self) weekSelf = self;
    self.notificationToken = [self.serverRealmFiles addNotificationBlock:^(RLMResults *results, RLMCollectionChange *change, NSError *error) {
        [weekSelf.tableView reloadData];
    }];

    [self.progressIndicator removeFromSuperview];
    self.tableView.hidden = NO;
    self.searchField.enabled = YES;
}

#pragma mark - Actions

- (void)tableViewDoubleAction:(id)sender {
    if (self.tableView.clickedRow == self.tableView.selectedRow) {
        if (self.onSelectURL) {
            self.onSelectURL(self.selectedURL);
        }
    }
}

- (void)keyDown:(NSEvent *)event {
    unichar key = [event.charactersIgnoringModifiers characterAtIndex:0];

    if (key == NSCarriageReturnCharacter) {
        if (self.onSelectURL) {
            self.onSelectURL(self.selectedURL);
        }
    } else {
        [super keyDown:event];
    }
}

- (void)cancel:(id)sender {
    [self closeWithReturnCode:NSModalResponseCancel];
}

#pragma mark - NSSearchFieldDelegate

- (void)controlTextDidChange:(NSNotification *)obj {
    self.filteredServerRealmFiles = [self.serverRealmFiles objectsWhere:@"path CONTAINS %@", self.searchField.stringValue];
    [self.tableView reloadData];
}

- (void)searchFieldDidEndSearching:(NSSearchField *)sender {
    self.filteredServerRealmFiles = self.serverRealmFiles;
    [self.tableView reloadData];
}

#pragma mark - NSTableViewDataSource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return self.filteredServerRealmFiles.count;
}

#pragma mark - NSTableViewDelegate

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:@"PathCell" owner:self];

    cellView.textField.stringValue = self.filteredServerRealmFiles[row][@"path"];

    return cellView;
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification {
    if (self.tableView.selectedRow >= 0) {
        NSString *realmPath = [self.filteredServerRealmFiles[self.tableView.selectedRow] valueForKey:@"path"];
        self.selectedURL = [[NSURL alloc] initWithString:realmPath relativeToURL:self.serverURL];
    } else {
        self.selectedURL = nil;
    }
}

@end

