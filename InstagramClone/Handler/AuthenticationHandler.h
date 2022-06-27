//
//  AuthenticationHandler.h
//  InstagramClone
//
//  Created by Angelina Zhang on 6/27/22.
//

#import <Foundation/Foundation.h>
#import "LoginView.h"

NS_ASSUME_NONNULL_BEGIN

@interface AuthenticationHandler : NSObject

@property (nonatomic) LoginView *loginView;
@property (nonatomic) BOOL success;

- (instancetype)init:(LoginView *)view;
- (void)registerUser;
- (void)loginUser;

@end

NS_ASSUME_NONNULL_END
