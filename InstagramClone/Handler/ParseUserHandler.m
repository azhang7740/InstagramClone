//
//  ParseUserHandler.m
//  InstagramClone
//
//  Created by Angelina Zhang on 6/30/22.
//

#import "ParseUserHandler.h"
#import <Parse/Parse.h>

@implementation ParseUserHandler

- (NSString *)getCurrentUserName {
    PFUser *user = [PFUser currentUser];
    return user.username;
}

- (void)addProfilePicture: (UIImage *)image {
    [ParseUserHandler uploadProfilePicture:image
                            withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if (error) {
            [self.delegate failedRequest:@"Your profile picture wasn't successfully uploaded."];
        }
    }];
}

+ (void) uploadProfilePicture: (UIImage * _Nullable )image
               withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    PFUser *currentUser = [PFUser currentUser];
    currentUser[@"profilePicture"] = [ParseUserHandler getPFFileFromImage:image];
    
    [currentUser saveInBackgroundWithBlock: completion];
}

+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
 
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    if (!imageData) {
        return nil;
    }
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
}

- (void)getUserProfilePicture:(NSString *)username {
    PFQuery *query = [PFUser query];
    [query includeKey:@"profilePicture"];
    [query whereKey:@"username" equalTo:username];
    
    query.limit = 1;

    [query findObjectsInBackgroundWithBlock:^(NSArray<PFUser *> *users, NSError *error) {
        if (users != nil && users.count > 0) {
            if (users[0][@"profilePicture"]) {
                [users[0][@"profilePicture"] getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
                    if (!error) {
                        [self.delegate didLoadUserInfo:data];
                    }
                }];
            }
        } else {
            [self.delegate failedRequest:@"Failed to find user."];
        }
    }];
}

@end
