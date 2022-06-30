//
//  ProfileView.h
//  InstagramClone
//
//  Created by Angelina Zhang on 6/30/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProfileView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *profileUsername;

@end

NS_ASSUME_NONNULL_END
