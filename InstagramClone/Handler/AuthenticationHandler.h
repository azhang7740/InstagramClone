//
//  AuthenticationHandler.h
//  InstagramClone
//
//  Created by Angelina Zhang on 6/27/22.
//

#import <Foundation/Foundation.h>
#import "LoginView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol AuthenticationDelegate

- (void)completedAuthentication;

@end

@interface AuthenticationHandler : NSObject

@property (nonatomic) LoginView *loginView;
@property (nonatomic, weak) id<AuthenticationDelegate> delegate;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

- (instancetype)init:(LoginView *)view;
- (void)registerUser;
- (void)loginUser;

@end

NS_ASSUME_NONNULL_END
