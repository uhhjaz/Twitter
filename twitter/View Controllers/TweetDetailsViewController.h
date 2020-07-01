//
//  TweetDetailsViewController.h
//  twitter
//
//  Created by Jasdeep Gill on 6/30/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface TweetDetailsViewController : UIViewController

@property (nonatomic, strong) Tweet *tweet;
- (void) refreshDataForLike;
- (void) refreshDataForRetweet;

@end

NS_ASSUME_NONNULL_END
