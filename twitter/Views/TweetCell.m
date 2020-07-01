//
//  TweetCell.m
//  twitter
//
//  Created by Jasdeep Gill on 6/29/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "APIManager.h"

static NSString * const POST_FAVORITE = @"1.1/favorites/create.json";
static NSString * const POST_UNFAVORITE = @"1.1/favorites/destroy.json";
static NSString * const POST_RETWEET = @"1.1/statuses/retweet.json";
static NSString * const POST_UNRETWEET = @"1.1/statuses/unretweet.json";

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
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
        self.likesButton.selected = YES;
    }
    else {
        self.likesButton.selected = NO;

    }
    self.likesCountLabel.text = [@(self.tweet.favoriteCount) stringValue];
    
}


@end
