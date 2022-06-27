//
//  LoginViewController.m
//  InstagramClone
//
//  Created by Angelina Zhang on 6/27/22.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "AuthenticationHandler.h"

@interface LoginViewController ()

@property (strong, nonatomic) IBOutlet LoginView *loginView;
@property (nonatomic) AuthenticationHandler *authenticate;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.authenticate = [[AuthenticationHandler alloc] init:self.loginView];
}

- (IBAction)onTapSignUp:(id)sender {

}

- (IBAction)onTapLogin:(id)sender {
    
}

@end
