//
//  ParsePostHandler.m
//  InstagramClone
//
//  Created by Angelina Zhang on 6/29/22.
//

#import "ParsePostHandler.h"
#import "RemotePost.h"
#import "PostBuilder.h"

@implementation ParsePostHandler

- (void) post: (UIImage * _Nullable )image
  withCaption: (NSString * _Nullable )caption {
    [ParsePostHandler postUserImage:image withCaption:caption
         withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if (error) {
            [self.delegate failedToPost];
        } else {
            [self.delegate postedSuccessfully];
        }
    }];
}

- (void)queryHomePosts{
    PostBuilder *build = [[PostBuilder alloc] init];
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
    [query includeKey:@"createdAt"];
    
    query.limit = 20;

    [query findObjectsInBackgroundWithBlock:^(NSArray<RemotePost *> *posts, NSError *error) {
        if (posts != nil) {
            NSMutableArray<Post *> *newPosts = [build getPostsFromRemoteArray:posts];
            [self.delegate successfullyQueried:newPosts];
        } else {
            
        }
    }];
}

+ (void) postUserImage: (UIImage * _Nullable )image
           withCaption: (NSString * _Nullable )caption
        withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    RemotePost *newPost = [RemotePost new];
    newPost.image = [self getPFFileFromImage:image];
    newPost.author = [PFUser currentUser];
    newPost.caption = caption;
    newPost.likeCount = @(0);
    newPost.commentCount = @(0);
    
    [newPost saveInBackgroundWithBlock: completion];
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

@end