//
//  TweetCell.h
//  twitter
//
//  Created by Jasdeep Gill on 6/29/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
#import "TweetCell.h"
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TweetCellDelegate;
@interface TweetCell : UITableViewCell


@property (nonatomic, weak) id<TweetCellDelegate> delegate;
// MARK: Properties
@property (strong, nonatomic) Tweet *tweet;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetContent;
@property (weak, nonatomic) IBOutlet UIButton *repliesButton;
@property (weak, nonatomic) IBOutlet UILabel *repliesCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UILabel *retweetCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *likesButton;
@property (weak, nonatomic) IBOutlet UILabel *likesCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;

// MARK: Methods
- (void) refreshDataForLike;
- (void) refreshDataForRetweet;

@end

@protocol TweetCellDelegate
// TODO: Add required methods the delegate needs to implement
- (void)tweetCell:(TweetCell *) tweetCell didTap: (User *)user;
@end

NS_ASSUME_NONNULL_END
