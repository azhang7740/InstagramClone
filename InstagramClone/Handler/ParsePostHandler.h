//
//  ParsePostHandler.h
//  InstagramClone
//
//  Created by Angelina Zhang on 6/29/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ParsePostHandlerDelegate

- (void)postedSuccessfully;
- (void)failedToPost;
- (void)successfullyQueried:(NSMutableArray<Post *> *)posts;
- (void)didLoadImageData:(NSData *)data;

@end

@interface ParsePostHandler : NSObject

@property (nonatomic, weak) id<ParsePostHandlerDelegate> delegate;

- (void) post: (UIImage * _Nullable )image
  withCaption: (NSString * _Nullable )caption;

- (void)queryHomePosts;

@end

NS_ASSUME_NONNULL_END
