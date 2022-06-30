//
//  ParseUserHandler.h
//  InstagramClone
//
//  Created by Angelina Zhang on 6/30/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ParseUserHandlerDelegate

- (void)failedRequest:(NSString *)errorMessage;
- (void)didLoadUserInfo:(NSData *)imageData;

@end

@interface ParseUserHandler : NSObject

@property (nonatomic, weak) id<ParseUserHandlerDelegate> delegate;

- (NSString *)getCurrentUserName;
- (void)addProfilePicture: (UIImage *)image;
- (void)getUserProfilePicture:(NSString *)username;

@end

NS_ASSUME_NONNULL_END
