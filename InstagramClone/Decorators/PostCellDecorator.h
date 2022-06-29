//
//  PostCellDecorator.h
//  InstagramClone
//
//  Created by Angelina Zhang on 6/29/22.
//

#import <Foundation/Foundation.h>
#import "PostCell.h"
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface PostCellDecorator : NSObject

- (void)decorateCell:(PostCell *)cell
            withPost: (Post *)post;

@end

NS_ASSUME_NONNULL_END
