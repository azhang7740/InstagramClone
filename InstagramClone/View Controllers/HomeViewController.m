//
//  HomeViewController.m
//  InstagramClone
//
//  Created by Angelina Zhang on 6/27/22.
//

#import "HomeViewController.h"
#import "LogoutHandler.h"
#import "ComposeViewController.h"
#import "DetailsViewController.h"

#import "PostCell.h"
#import "PostCellDecorator.h"

#import "ParsePostHandler.h"

@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate, ComposeViewControllerDelegate, ParsePostHandlerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *timelineTableView;
@property (nonatomic, strong) NSMutableArray<Post *> *posts;
@property (nonatomic, strong) ParsePostHandler *postHandler;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.timelineTableView.delegate = self;
    self.timelineTableView.dataSource = self;
    
    self.postHandler = [[ParsePostHandler alloc] init];
    self.postHandler.delegate = self;
    [self fetchPosts];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self
                       action:@selector(beginRefresh:)
             forControlEvents:UIControlEventValueChanged];
    [self.timelineTableView insertSubview:refreshControl atIndex:0];
    
    UINib *nib = [UINib nibWithNibName:@"PostCell" bundle:nil];
    [self.timelineTableView registerNib:nib forCellReuseIdentifier:@"PostCellId"];
}

- (void)fetchPosts {
    [self.postHandler queryHomePosts];
}

- (void)successfullyQueried:(NSMutableArray<Post *> *)posts {
    self.posts = posts;
    [self.timelineTableView reloadData];
}

- (void)postedSuccessfully {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)failedToPost {
    
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

- (void)didTapShare:(UIImage *)image
        withCaption:(NSString *)caption {
    [self.postHandler post:image withCaption:caption];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView
                 cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCellId"
                                                      forIndexPath:indexPath];
    if (indexPath.row < self.posts.count) {
        PostCellDecorator *decorator = [[PostCellDecorator alloc] init];
        [decorator decorateCell:cell withPost:self.posts[indexPath.row]];
    }
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UINavigationController *navigationController = self.navigationController;
    DetailsViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsViewController"];
    if (indexPath.row < self.posts.count) {
        viewController.post = self.posts[indexPath.row];
        [navigationController pushViewController: viewController animated:YES];
    }
}

- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    [self fetchPosts];
    [refreshControl endRefreshing];
}

@end
