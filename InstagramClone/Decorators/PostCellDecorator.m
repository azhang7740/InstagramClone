//
//  PostCellDecorator.m
//  InstagramClone
//
//  Created by Angelina Zhang on 6/29/22.
//

#import "PostCellDecorator.h"
#import "DateTools.h"

@implementation PostCellDecorator

- (void)decorateCell:(PostCell *)cell
            withPost: (Post *)post {
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.usernameLabel.text = post.authorUsername;
    cell.postImage.image = [UIImage imageWithData:post.imageData];
    cell.captionTextView.text = post.caption;
    cell.dateLabel.text = [post.createdAtDate shortTimeAgoSinceNow];
}

@end
