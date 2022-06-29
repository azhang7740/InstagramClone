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

#import "Post.h"

@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate, ComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *timelineTableView;
@property (nonatomic, strong) NSArray<Post *> *posts;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.timelineTableView.delegate = self;
    self.timelineTableView.dataSource = self;
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
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    query.limit = 20;

    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            self.posts = posts;
            [self.timelineTableView reloadData];
        } else {
            
        }
    }];
    
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
    [Post postUserImage:image withCaption:caption withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if (error) {
            
        } else {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView
                 cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCellId"
                                                      forIndexPath:indexPath];
    if (indexPath.row < self.posts.count) {
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        PFFileObject *image = self.posts[indexPath.row].image;
        [image getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
            if (!error) {
                cell.postImage.image = [UIImage imageWithData:data];
            }
        }];
        cell.captionTextView.text = self.posts[indexPath.row].caption;
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
