//
//  Post.h
//  InstagramClone
//
//  Created by Angelina Zhang on 6/27/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Post : NSObject

@property (nonatomic, strong) NSString *postID;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *authorUsername;
@property (nonatomic, strong) NSDate *createdAtDate;

@property (nonatomic, strong) NSString *caption;
@property (nonatomic, strong) NSData *imageData;
@property (nonatomic, strong) NSNumber *likeCount;
@property (nonatomic, strong) NSNumber *commentCount;

@end

NS_ASSUME_NONNULL_END
