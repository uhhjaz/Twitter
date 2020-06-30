//
//  TweetCell.m
//  twitter
//
//  Created by Jasdeep Gill on 6/29/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "APIManager.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)didTapLike:(id)sender {
    if (self.tweet.favorited){
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
    }
    else{
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
    }
    [self refreshDataForLike];
}

- (IBAction)didTapRetweet:(id)sender {
    if (self.tweet.retweeted){
        self.tweet.retweeted = NO;
        self.tweet.retweetCount -= 1;
    }
    else{
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
    }
    [self refreshDataForRetweet];
}


- (void) refreshDataForRetweet {
    if (self.tweet.retweeted) {
        self.retweetButton.selected = YES;
        self.retweetCountLabel.text = [@(self.tweet.retweetCount) stringValue];
        
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
            }
        }];
    }
    
    else {
        self.retweetButton.selected = NO;
        self.retweetCountLabel.text = [@(self.tweet.retweetCount) stringValue];
        
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
            }
        }];
    }
    
}

- (void) refreshDataForLike {
    if (self.tweet.favorited) {
        self.likesButton.selected = YES;
        self.likesCountLabel.text = [@(self.tweet.favoriteCount) stringValue];
        
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
                
            }
        }];
    }
    else {
        self.likesButton.selected = NO;
        self.likesCountLabel.text = [@(self.tweet.favoriteCount) stringValue];
        
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);

            }
        }];
    }
    
}


@end