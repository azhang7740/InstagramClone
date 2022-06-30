//
//  ComposeViewController.m
//  InstagramClone
//
//  Created by Angelina Zhang on 6/27/22.
//

#import "ComposeViewController.h"
#import "ComposeView.h"

@interface ComposeViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate>

@property (strong, nonatomic) IBOutlet ComposeView *composeView;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.composeView.postCaption.text = @"Type here...";
    self.composeView.postCaption.textColor = UIColor.lightGrayColor;
    self.composeView.postCaption.delegate = self;
}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    self.composeView.postImage.image = editedImage;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onTapCamera:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:imagePickerVC animated:YES completion:nil];
    } else {
        
    }
}

- (IBAction)onTapLibrary:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (IBAction)onTapCancel:(id)sender {
    [self.delegate didTapCancel];
}

- (IBAction)onTapShare:(id)sender {
    [self.delegate didTapShare:self.composeView.postImage.image
                   withCaption:self.composeView.postCaption.text];
}

- (IBAction)onTapOutside:(id)sender {
    [self.view endEditing:true];
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    BOOL isEmptyCaption = self.composeView.postCaption.textColor == UIColor.lightGrayColor;
    if (isEmptyCaption) {
        self.composeView.postCaption.text = nil;
        self.composeView.postCaption.textColor = UIColor.blackColor;
    }

}

- (void)textViewDidEndEditing:(UITextView *)textView {
    BOOL isEmptyCaption = [self.composeView.postCaption.text length] == 0;
    if (isEmptyCaption) {
        self.composeView.postCaption.text = @"Type here...";
        self.composeView.postCaption.textColor = UIColor.lightGrayColor;
    }
}

@end
