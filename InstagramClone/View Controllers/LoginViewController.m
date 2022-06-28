//
//  LoginViewController.m
//  InstagramClone
//
//  Created by Angelina Zhang on 6/27/22.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "AuthenticationHandler.h"

@interface LoginViewController () <AuthenticationDelegate, UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet LoginView *loginView;
@property (nonatomic) AuthenticationHandler *authenticate;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loginView.errorLabel.text = @"";
    self.authenticate = [[AuthenticationHandler alloc] init:self.loginView];
    self.authenticate.delegate = self;
    
    self.loginView.passwordTextField.delegate = self;
    self.loginView.usernameTextField.delegate = self;
}

- (void)performSegueToHome {
    UITabBarController *tabBarController = (UITabBarController*)[self.storyboard instantiateViewControllerWithIdentifier:@"TabBarController"];
   [self presentViewController:tabBarController animated:YES completion:nil];
}

- (IBAction)onTapSignUp:(id)sender {
    [self.authenticate registerUser];
}

- (IBAction)onTapLogin:(id)sender {
    [self.authenticate loginUser];
}

- (IBAction)onTapOutside:(id)sender {
    [self.view endEditing:true];
}

@end
