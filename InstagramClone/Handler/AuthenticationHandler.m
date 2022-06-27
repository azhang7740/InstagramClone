//
//  AuthenticationHandler.m
//  InstagramClone
//
//  Created by Angelina Zhang on 6/27/22.
//

#import "AuthenticationHandler.h"
#import <Parse/Parse.h>

@implementation AuthenticationHandler

- (NSError *)registerUser:(NSString *)username
        withPassword:(NSString *)password {
    PFUser *newUser = [PFUser user];
    
    newUser.username = username;
    newUser.password = password;
    
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        return error;
    }];
}

- (NSError *)loginUser:(NSString *)username
     withPassword:(NSString *)password {
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        return error;
    }];
}

@end
