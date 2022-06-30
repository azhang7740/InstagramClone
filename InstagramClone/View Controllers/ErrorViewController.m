//
//  ErrorViewController.m
//  InstagramClone
//
//  Created by Angelina Zhang on 6/30/22.
//

#import "ErrorViewController.h"

@interface ErrorViewController ()

@property (weak, nonatomic) IBOutlet UILabel *errorMessageLabel;

@end

@implementation ErrorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.errorMessageLabel.text = self.message;
}

- (IBAction)onTapClose:(id)sender {
    [self.delegate didTapClose];
}

@end
