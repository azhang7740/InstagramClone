//
//  ComposeView.h
//  InstagramClone
//
//  Created by Angelina Zhang on 6/27/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ComposeView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *postImage;
@property (weak, nonatomic) IBOutlet UITextView *postCaption;

@end

NS_ASSUME_NONNULL_END
