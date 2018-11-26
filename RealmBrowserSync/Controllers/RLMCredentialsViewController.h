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

@import Cocoa;
@import Realm;

extern RLMIdentityProvider const RLMIdentityProviderAccessToken;

@class RLMCredentialsViewController;

@protocol RLMCredentialsViewControllerDelegate<NSObject>
@optional
- (BOOL)credentialsViewController:(RLMCredentialsViewController *)controller shoudShowCredentialsViewForIdentityProvider:(RLMIdentityProvider)provider;
- (NSString *)credentialsViewController:(RLMCredentialsViewController *)controller labelForIdentityProvider:(RLMIdentityProvider)provider;
- (void)credentialsViewControllerDidChangeCredentials:(RLMCredentialsViewController *)controller;

@end

@interface RLMCredentialsViewController : NSViewController

@property (nonatomic, weak) id<RLMCredentialsViewControllerDelegate> delegate;
@property (nonatomic, strong) RLMSyncCredentials *credentials;

- (void)reloadCredentialViews;

@end
