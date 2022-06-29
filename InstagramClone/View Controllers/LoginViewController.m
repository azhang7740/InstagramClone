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
@property (nonatomic) AuthenticationHandler *authenticationHandler;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loginView.errorLabel.text = @"";
    self.authenticationHandler = [[AuthenticationHandler alloc] init];
    self.authenticationHandler.delegate = self;
    
    self.loginView.passwordTextField.delegate = self;
    self.loginView.usernameTextField.delegate = self;
    self.loginView.passwordTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.loginView.usernameTextField.autocorrectionType = UITextAutocorrectionTypeNo;
}

- (void)performSegueToHome {
    UITabBarController *tabBarController = (UITabBarController*)[self.storyboard instantiateViewControllerWithIdentifier:@"TabBarController"];
   [self presentViewController:tabBarController animated:YES completion:nil];
}

- (void)completedAuthentication {
    [self performSegueToHome];
}

- (void)failedAuthentication:(NSString *)errorMessage {
    self.loginView.errorLabel.text = errorMessage;
}

- (IBAction)onTapSignUp:(id)sender {
    [self.authenticationHandler registerUser:self.loginView.usernameTextField.text
                                withPassword:self.loginView.passwordTextField.text];
}

- (IBAction)onTapLogin:(id)sender {
    [self.authenticationHandler loginUser:self.loginView.usernameTextField.text
                             withPassword:self.loginView.passwordTextField.text];
}

- (IBAction)onTapOutside:(id)sender {
    [self.view endEditing:true];
}

@end
