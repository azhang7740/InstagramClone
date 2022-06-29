//
//  ComposeViewController.h
//  InstagramClone
//
//  Created by Angelina Zhang on 6/27/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ComposeViewControllerDelegate

- (void)didTapCancel;
- (void)didTapShare:(UIImage *)image
        withCaption:(NSString *)caption;

@end

@interface ComposeViewController : UIViewController

@property (nonatomic, weak) id<ComposeViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
