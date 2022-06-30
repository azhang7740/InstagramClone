//
//  ProfileViewController.m
//  InstagramClone
//
//  Created by Angelina Zhang on 6/30/22.
//

#import "ProfileViewController.h"
#import "ProfileView.h"
#import "ParsePostHandler.h"
#import "Post.h"
#import "PostCollectionCell.h"

@interface ProfileViewController () <ParsePostHandlerDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) IBOutlet ProfileView *profileView;
@property (weak, nonatomic) IBOutlet UICollectionView *postsCollectionView;
@property (nonatomic) NSMutableArray<Post *> *posts;
@property (nonatomic) ParsePostHandler *postHandler;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.postsCollectionView.delegate = self;
    self.postsCollectionView.dataSource = self;
    self.postHandler = [[ParsePostHandler alloc] init];
    self.postHandler.delegate = self;
    [self fetchPosts];
}

- (void)fetchPosts {
    [self.postHandler querySelfProfilePosts];
}

- (void)didLoadImageData:(nonnull Post *)post {
    [self.postsCollectionView reloadData];
}

- (void)failedRequest:(nonnull NSString *)errorMessage {
    
}

- (void)successfullyQueried:(nonnull NSMutableArray<Post *> *)posts {
    self.posts = posts;
    [self.postsCollectionView reloadData];
}

- (void)successfullyQueriedMore:(nonnull NSMutableArray<Post *> *)posts {
    
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PostCollectionCell"
                                                                         forIndexPath:indexPath];
    if (indexPath.row < self.posts.count) {
        cell.postImage.image = [UIImage imageWithData:self.posts[indexPath.row].imageData];
    }
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.posts.count;
}

@end
