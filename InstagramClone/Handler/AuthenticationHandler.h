//
//  AuthenticationHandler.h
//  InstagramClone
//
//  Created by Angelina Zhang on 6/27/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AuthenticationHandler : NSObject

- (NSError *)registerUser:(NSString *)username
        withPassword:(NSString *)password;
- (NSError *)loginUser:(NSString *)username
     withPassword:(NSString *)password;

@end

NS_ASSUME_NONNULL_END
