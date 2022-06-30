//
//  ProfileViewController.m
//  InstagramClone
//
//  Created by Angelina Zhang on 6/30/22.
//

#import "ProfileViewController.h"
#import "ProfileView.h"

#import "ParsePostHandler.h"
#import "ParseUserHandler.h"
#import "Post.h"
#import "PostCollectionCell.h"

#import "ErrorViewController.h"
#import "DetailsViewController.h"

@interface ProfileViewController () <ParsePostHandlerDelegate, ParseUserHandlerDelegate, ErrorViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) IBOutlet ProfileView *profileView;
@property (weak, nonatomic) IBOutlet UICollectionView *postsCollectionView;
@property (nonatomic) NSMutableArray<Post *> *posts;
@property (nonatomic) ParsePostHandler *postHandler;
@property (nonatomic) ParseUserHandler *userHandler;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.postsCollectionView.delegate = self;
    self.postsCollectionView.dataSource = self;
    
    self.postHandler = [[ParsePostHandler alloc] init];
    self.postHandler.delegate = self;
    self.userHandler = [[ParseUserHandler alloc] init];
    self.userHandler.delegate = self;
    
    [self fetchUserInfo];
    [self fetchPosts];
}

- (void)fetchPosts {
    [self.postHandler querySelfProfilePosts];
}

- (void)fetchUserInfo {
    if (!self.username) {
        NSString *username = [self.userHandler getCurrentUserName];
        self.profileView.profileUsername.text = username;
        [self.userHandler getUserProfilePicture:username];
    } else {
        self.profileView.profileUsername.text = self.username;
        self.profileView.profileImage.image = [UIImage imageWithData:self.imageData];
    }
    self.profileView.profileImage.layer.cornerRadius =
    self.profileView.profileImage.frame.size.width / 2;
}

- (void)didLoadImageData:(nonnull Post *)post {
    for (int i = 0; i < self.posts.count; i++) {
        if ([post.postID isEqual:self.posts[i].postID]) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
            PostCollectionCell *cell = (PostCollectionCell *)[self.postsCollectionView cellForItemAtIndexPath:indexPath];
            cell.postImage.image = [UIImage imageWithData:post.imageData];
        }
    }
}

- (void)failedRequest:(nonnull NSString *)errorMessage {
    UINavigationController *errorNavigationController = (UINavigationController*)[self.storyboard instantiateViewControllerWithIdentifier:@"ErrorNavigation"];
    ErrorViewController *errorController = (ErrorViewController*)errorNavigationController.topViewController;
    errorController.delegate = self;
    errorController.message = errorMessage;
    [self presentViewController:errorNavigationController animated:YES completion:nil];
}

- (void)didLoadUserInfo:(nonnull NSData *)imageData {
    self.imageData = imageData;
    self.profileView.profileImage.image = [UIImage imageWithData:self.imageData];
}

- (void)didTapClose {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)successfullyQueried:(nonnull NSMutableArray<Post *> *)posts {
    self.posts = posts;
    [self.postsCollectionView reloadData];
}

- (void)successfullyQueriedMore:(nonnull NSMutableArray<Post *> *)posts {
    for (int i = 0; i < posts.count; i++) {
        [self.posts addObject:posts[i]];
    }
    [self.postsCollectionView reloadData];
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCollectionCell *cell = [collectionView
                                dequeueReusableCellWithReuseIdentifier:@"PostCollectionCell"
                                forIndexPath:indexPath];
    if (indexPath.row < self.posts.count) {
        cell.postImage.image = [UIImage imageWithData:self.posts[indexPath.row].imageData];
    }
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.posts.count;
}

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UINavigationController *navigationController = self.navigationController;
    DetailsViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsViewController"];
    if (indexPath.row < self.posts.count) {
        viewController.post = self.posts[indexPath.row];
        [navigationController pushViewController: viewController animated:YES];
    }
}
- (IBAction)onTapEdit:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    self.profileView.profileImage.image = editedImage;
    [self.userHandler addProfilePicture:editedImage];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
