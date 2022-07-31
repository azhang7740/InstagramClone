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
#import "ErrorViewController.h"

#import "PostCell.h"
#import "PostCellDecorator.h"

#import "ParsePostHandler.h"

@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate, ComposeViewControllerDelegate,
ParsePostHandlerDelegate, LogoutHandlerDelegate, ErrorViewControllerDelegate>

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
    self.posts = [[NSMutableArray alloc] init];
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

- (void)fetchMorePosts:(Post *)post {
    [self.postHandler queryMorePosts:post];
}

- (void)successfullyQueried:(NSMutableArray<Post *> *)posts {
    self.posts = posts;
    [self.timelineTableView reloadData];
}

- (void)successfullyQueriedMore:(NSMutableArray<Post *> *)posts {
    for (int i = 0; i < posts.count; i++) {
        [self.posts addObject:posts[i]];
    }
    [self.timelineTableView reloadData];
}

- (void)didLoadImageData:(Post *)post {
    for (int i = 0; i < self.posts.count; i++) {
        if (post.postID == self.posts[i].postID) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            PostCell *cell = [self.timelineTableView cellForRowAtIndexPath:indexPath];
            PostCellDecorator *decorator = [[PostCellDecorator alloc] init];
            [decorator decorateCell:cell withPost:self.posts[indexPath.row]];
        }
    }
}

- (void)failedRequest:(NSString *)errorMessage {
    UINavigationController *errorNavigationController = (UINavigationController*)[self.storyboard instantiateViewControllerWithIdentifier:@"ErrorNavigation"];
    ErrorViewController *errorController = (ErrorViewController*)errorNavigationController.topViewController;
    errorController.delegate = self;
    errorController.message = errorMessage;
    [self presentViewController:errorNavigationController animated:YES completion:nil];
}

- (void)failedLogout {
    UINavigationController *errorNavigationController = (UINavigationController*)[self.storyboard instantiateViewControllerWithIdentifier:@"ErrorNavigation"];
    ErrorViewController *errorController = (ErrorViewController*)errorNavigationController.topViewController;
    errorController.delegate = self;
    errorController.message = @"Failed to logout.";
    [self presentViewController:errorNavigationController animated:YES completion:nil];
}

- (IBAction)onTapLogout:(id)sender {
    LogoutHandler *logoutAction = [[LogoutHandler alloc] init];
    logoutAction.delegate = self;
    [logoutAction logout];
}

- (IBAction)onTapCompose:(id)sender {
    UINavigationController *composeNavigationController = (UINavigationController*)[self.storyboard instantiateViewControllerWithIdentifier:@"ComposeNavigation"];
    ComposeViewController *viewController = (ComposeViewController *)composeNavigationController.topViewController;
    viewController.delegate = self;
    [self presentViewController:composeNavigationController animated:YES completion:nil];
}

- (void)didTapCancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didTapClose {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didTapShare:(UIImage *)image
        withCaption:(NSString *)caption {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.postHandler post:image withCaption:caption];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView
                 cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCellId"
                                                      forIndexPath:indexPath];
    if (indexPath.row < self.posts.count) {
        PostCellDecorator *decorator = [[PostCellDecorator alloc] init];
        [decorator decorateCell:cell withPost:self.posts[indexPath.row]];
        
        if (indexPath.row == self.posts.count - 1) {
            [self fetchMorePosts:self.posts[indexPath.row - 1]];
        }
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
