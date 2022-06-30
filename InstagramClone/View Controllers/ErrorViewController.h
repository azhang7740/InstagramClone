//
//  ErrorViewController.h
//  InstagramClone
//
//  Created by Angelina Zhang on 6/30/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ErrorViewControllerDelegate

- (void)didTapClose;

@end

@interface ErrorViewController : UIViewController

@property (nonatomic, weak) id<ErrorViewControllerDelegate> delegate;
@property (nonatomic, strong) NSString *message;

@end

NS_ASSUME_NONNULL_END
