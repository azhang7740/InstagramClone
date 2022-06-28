//
//  HomeViewController.m
//  InstagramClone
//
//  Created by Angelina Zhang on 6/27/22.
//

#import "HomeViewController.h"
#import "LogoutHandler.h"
#import "ComposeViewController.h"

@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate, ComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *timelineTableView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.timelineTableView.delegate = self;
    self.timelineTableView.dataSource = self;
}

- (IBAction)onTapLogout:(id)sender {
    LogoutHandler *logoutAction = [[LogoutHandler alloc] init];
    [logoutAction logout];
}

- (IBAction)onTapCompose:(id)sender {
    UINavigationController *composeNavigationController = (UINavigationController*)[self.storyboard instantiateViewControllerWithIdentifier:@"ComposeNavigation"];
   [self presentViewController:composeNavigationController animated:YES completion:nil];
    ComposeViewController *composeController = (ComposeViewController*)composeNavigationController.topViewController;
    composeController.delegate = self;
}

- (void)didTapCancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didTapShare {
    
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return nil;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
