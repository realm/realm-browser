////////////////////////////////////////////////////////////////////////////
//
// Copyright 2014-2015 Realm Inc.
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

@import Realm.Private;
@import Realm.Dynamic;

#import "RLMRealmNode.h"

@interface RLMRealmNode ()

@property (nonatomic, strong) RLMRealmConfiguration *configuration;

@end

@implementation RLMRealmNode

- (instancetype)initWithFileURL:(NSURL *)fileURL {
    self = [super init];

    if (self) {
        self.disableFormatUpgrade = YES;

        self.configuration = [[RLMRealmConfiguration alloc] init];
        self.configuration.dynamic = YES;
        self.configuration.fileURL = fileURL;
    }

    return self;
}

- (instancetype)initWithSyncURL:(NSURL *)syncURL localURL:(NSURL *)localURL user:(RLMSyncUser *)user {
    self = [super init];

    if (self) {
        self.configuration = [[RLMRealmConfiguration alloc] init];
        self.configuration.dynamic = YES;

        RLMSyncConfiguration *syncConfiguration = [[RLMSyncConfiguration alloc] initWithUser:user realmURL:syncURL];
        syncConfiguration.customFileURL = localURL;

        self.configuration.syncConfiguration = syncConfiguration;
    }

    return self;
}

- (BOOL)connect:(NSError **)error {
    self.configuration.encryptionKey = self.encryptionKey;
    self.configuration.disableFormatUpgrade = self.disableFormatUpgrade;

    NSError *localError;
    _realm = [RLMRealm realmWithConfiguration:self.configuration error:&localError];

    if (localError) {
        NSLog(@"Realm was opened with error: %@", localError);
    } else {
        _topLevelClasses = [self constructTopLevelClasses];
    }

    if (error) {
        *error = localError;
    }

    return !localError;
}

#pragma mark - RLMRealmOutlineNode implementation

- (BOOL)isRootNode
{
    return YES;
}

- (BOOL)isExpandable
{
    return self.topLevelClasses.count != 0;
}

- (NSUInteger)numberOfChildNodes
{
    return self.topLevelClasses.count;
}

- (id<RLMRealmOutlineNode>)childNodeAtIndex:(NSUInteger)index
{
    return self.topLevelClasses[index];
}

- (BOOL)hasToolTip
{
    return YES;
}

- (NSString *)toolTipString
{
    return self.configuration.fileURL.path;
}

- (NSView *)cellViewForTableView:(NSTableView *)tableView
{
    NSTableCellView *headerView = [tableView makeViewWithIdentifier:@"HeaderCell" owner:self];
    
    headerView.textField.stringValue = @"Models";
    
    return headerView;
}

#pragma mark - Private methods

- (NSArray *)constructTopLevelClasses
{
    RLMSchema *realmSchema = _realm.schema;
    NSArray *objectSchemas = realmSchema.objectSchema;

    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:objectSchemas.count];
    
    for (RLMObjectSchema *objectSchema in objectSchemas) {
        if (objectSchema.properties.count > 0) {
            RLMClassNode *tableNode = [[RLMClassNode alloc] initWithSchema:objectSchema inRealm:_realm];
            [result addObject:tableNode];
        }
    }

    [result sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]];

    return result;
}

@end
