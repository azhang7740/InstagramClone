//
//  PostBuilder.h
//  InstagramClone
//
//  Created by Angelina Zhang on 6/29/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Post.h"
#import "RemotePost.h"

NS_ASSUME_NONNULL_BEGIN

@protocol PostBuilderDelegate

- (void)didLoadImage:(Post *)post;

@end

@interface PostBuilder : NSObject

@property (nonatomic, weak) id<PostBuilderDelegate> delegate;

- (Post *)getPostFromRemotePost:(RemotePost *)remotePost;
- (NSMutableArray<Post *> *)getPostsFromRemoteArray:(NSArray<RemotePost *> *)remotePosts;

@end

NS_ASSUME_NONNULL_END
