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

#import "RLMLoginWindowController.h"
#import "RLMCredentialsViewController.h"
#import "NSView+RLMExtensions.h"

@interface RLMLoginWindowController ()<RLMCredentialsViewControllerDelegate>

@property (nonatomic, weak) IBOutlet NSTextField *messageLabel;
@property (nonatomic, weak) IBOutlet NSView *credentialsContainerView;
@property (nonatomic, weak) IBOutlet NSButton *okButton;

@property (nonatomic, strong) RLMCredentialsViewController *credentialsViewController;

@end

@implementation RLMLoginWindowController

- (instancetype)init {
    self = [super init];

    if (self != nil) {
        self.credentialsViewController = [[RLMCredentialsViewController alloc] init];
        self.credentialsViewController.delegate = self;
    }

    return self;
}

- (void)windowDidLoad {
    [super windowDidLoad];

    [self.credentialsContainerView addContentSubview:self.credentialsViewController.view];

    [self updateUI];
}

- (void)updateUI {
    self.okButton.enabled = self.credentials != nil;
}

- (NSString *)message {
    return self.messageLabel.stringValue;
}

- (void)setMessage:(NSString *)message {
    self.messageLabel.stringValue = message;
}

- (RLMSyncCredentials *)credentials {
    return self.credentialsViewController.credentials;
}

- (void)setCredentials:(RLMSyncCredentials *)credentials {
    self.credentialsViewController.credentials = credentials;

    [self updateUI];
}

- (IBAction)ok:(id)sender {
    if (self.credentials != nil) {
        [self closeWithReturnCode:NSModalResponseOK];
    }
}

- (IBAction)cancel:(id)sender {
    [self closeWithReturnCode:NSModalResponseCancel];
}

#pragma mark - RLMCredentialsViewControllerDelegate

- (void)credentialsViewControllerDidChangeCredentials:(RLMCredentialsViewController *)controller {
    [self updateUI];
}

@end
