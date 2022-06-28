//
//  HomeViewController.m
//  InstagramClone
//
//  Created by Angelina Zhang on 6/27/22.
//

#import "HomeViewController.h"
#import "LogoutHandler.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)onTapLogout:(id)sender {
    LogoutHandler *logoutAction = [[LogoutHandler alloc] init];
    [logoutAction logout];
}

@end
