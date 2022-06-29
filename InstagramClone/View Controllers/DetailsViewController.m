//
//  DetailsViewController.m
//  InstagramClone
//
//  Created by Angelina Zhang on 6/28/22.
//

#import "DetailsViewController.h"
#import "PostCell.h"
#import "PostCellDecorator.h"

@interface DetailsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *detailsTableView;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.detailsTableView.delegate = self;
    self.detailsTableView.dataSource = self;
    UINib *nib = [UINib nibWithNibName:@"PostCell" bundle:nil];
    [self.detailsTableView registerNib:nib forCellReuseIdentifier:@"PostCellId"];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView
                 cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCellId"
                                                      forIndexPath:indexPath];
    if (indexPath.row < 1) {
        PostCellDecorator *decorator = [[PostCellDecorator alloc] init];
        [decorator decorateCell:cell withPost:self.post];
    }
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

@end
