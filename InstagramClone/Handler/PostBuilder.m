//
//  PostBuilder.m
//  InstagramClone
//
//  Created by Angelina Zhang on 6/29/22.
//

#import "PostBuilder.h"

@implementation PostBuilder

- (Post *)getPostFromRemotePost:(RemotePost *)remotePost {
    Post *newPost = [[Post alloc] init];
    
    newPost.postID = remotePost.postID;
    newPost.userID = remotePost.userID;
    newPost.authorUsername = remotePost.author.username;
    newPost.createdAtDate = remotePost.createdAt;
    newPost.caption = remotePost.caption;
    
    PFFileObject *image = remotePost.image;
    newPost.likeCount = [remotePost.likeCount intValue];
    newPost.commentCount = [remotePost.commentCount intValue];
    newPost.imageData = UIImagePNGRepresentation([UIImage imageNamed:@"image_placeholder"]);
    [image getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (!error) {
            newPost.imageData = data;
            [self.delegate didLoadImage:newPost];
        } 
    }];
    return newPost;
}

- (NSMutableArray<Post *> *)getPostsFromRemoteArray:(NSArray<RemotePost *> *)remotePosts{
    NSMutableArray<Post *> *posts = [[NSMutableArray alloc] init];
    for (int i = 0; i < remotePosts.count; i++) {
        [posts addObject:[self getPostFromRemotePost:remotePosts[i]]];
    }
    return posts;
}

@end
