//
//  RemotePost.m
//  InstagramClone
//
//  Created by Angelina Zhang on 6/29/22.
//

#import "RemotePost.h"

@implementation RemotePost

@dynamic postID;
@dynamic userID;
@dynamic author;
@dynamic createdAt;
@dynamic caption;
@dynamic image;
@dynamic likeCount;
@dynamic commentCount;

+ (nonnull NSString *)parseClassName {
    return @"Post";
}

@end
