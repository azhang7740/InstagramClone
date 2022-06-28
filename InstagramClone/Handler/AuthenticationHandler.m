//
//  AuthenticationHandler.m
//  InstagramClone
//
//  Created by Angelina Zhang on 6/27/22.
//

#import "AuthenticationHandler.h"
#import <Parse/Parse.h>

@implementation AuthenticationHandler

- (instancetype)init:(LoginView *)view {
    self = [super init];
    
    self.loginView = view;
    return self;
}

- (BOOL)fieldsAreEmpty {
    return [self.loginView.usernameTextField.text isEqual:@""] ||
    [self.loginView.passwordTextField.text isEqual:@""];
}

- (void)registerUser {
    if ([self fieldsAreEmpty]) {
        self.loginView.errorLabel.text = @"Username or password field is empty.";
        return;
    }
    PFUser *newUser = [PFUser user];
    
    newUser.username = self.loginView.usernameTextField.text;
    newUser.password = self.loginView.passwordTextField.text;
    
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error) {
            self.loginView.errorLabel.text = @"Username is taken.";
        } else {
            [self.delegate completedAuthentication];
        }
    }];
}

- (void)loginUser {
    if ([self fieldsAreEmpty]) {
        self.loginView.errorLabel.text = @"Username or password field is empty.";
        return;
    }
    NSString *username = self.loginView.usernameTextField.text;
    NSString *password = self.loginView.passwordTextField.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error) {
            self.loginView.errorLabel.text = @"Invalid username or password";
        } else {
            [self.delegate completedAuthentication];
        }
    }];
}

@end
