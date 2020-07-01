//
//  TweetDetailsViewController.m
//  twitter
//
//  Created by Jasdeep Gill on 6/30/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "TweetDetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "TweetCell.h"
#import "Tweet.h"
#import "APIManager.h"

@interface TweetDetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *defaultPictureView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetContentLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *retweetCountLabel;


@end

static NSString * const POST_FAVORITE = @"1.1/favorites/create.json";
static NSString * const POST_UNFAVORITE = @"1.1/favorites/destroy.json";
static NSString * const POST_RETWEET = @"1.1/statuses/retweet.json";
static NSString * const POST_UNRETWEET = @"1.1/statuses/unretweet.json";

@implementation TweetDetailsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // update view labels for tweet
    self.nameLabel.text = self.tweet.user.name;
    self.usernameLabel.text = [@"@" stringByAppendingString:self.tweet.user.screenName];
    self.dateLabel.text = self.tweet.createdAtString;
    self.tweetContentLabel.text = self.tweet.text;
    self.likeCountLabel.text = [@(self.tweet.favoriteCount) stringValue];
    self.retweetCountLabel.text = [@(self.tweet.retweetCount) stringValue];

    

    // update profile image for tweet
    NSString *profileImageURLString = self.tweet.user.profileImageURLString;
    NSURL *profileImageURL = [NSURL URLWithString:profileImageURLString];
    [self.defaultPictureView setImageWithURL:profileImageURL];
    
    // refresh to update like and retweet status for tweet
    [self refreshDataForLike];
    [self refreshDataForRetweet];
}


- (IBAction)didTapLike:(id)sender {
    if (!self.tweet.favorited) {
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
        [[APIManager shared] updateTweetStatus:self.tweet :POST_FAVORITE completion:^(Tweet *tweet, NSError *error) {
            if(error){
                    NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
            }
            else{
                    NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
            }
        }];
    }
    else {
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
        [[APIManager shared] updateTweetStatus:self.tweet :POST_UNFAVORITE completion:^(Tweet *tweet, NSError *error) {
            if(error){
                    NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
            }
            else{
                    NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
            }
        }];
    }

    [self refreshDataForLike];
}


- (IBAction)didTapRetweet:(id)sender {
    if (!self.tweet.retweeted) {
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
        [[APIManager shared] updateTweetStatus:self.tweet :POST_RETWEET completion:^(Tweet *tweet, NSError *error) {
            if(error){
                    NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
            }
            else{
                    NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
            }
        }];
    }
    else {
        self.tweet.retweeted = NO;
        self.tweet.retweetCount -= 1;
        [[APIManager shared] updateTweetStatus:self.tweet :POST_UNRETWEET completion:^(Tweet *tweet, NSError *error) {
            if(error){
                    NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
            }
            else{
                    NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
            }
        }];
    }

    [self refreshDataForRetweet];
}


- (void) refreshDataForRetweet {
    if (self.tweet.retweeted) {
        self.retweetButton.selected = YES;
    }
    else {
        self.retweetButton.selected = NO;
    }
    self.retweetCountLabel.text = [@(self.tweet.retweetCount) stringValue];
    
}


- (void) refreshDataForLike {
    if (self.tweet.favorited) {
        self.likeButton.selected = YES;
    }
    else {
        self.likeButton.selected = NO;

    }
    self.likeCountLabel.text = [@(self.tweet.favoriteCount) stringValue];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
