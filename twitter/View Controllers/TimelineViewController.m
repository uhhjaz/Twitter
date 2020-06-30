//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"
#import "TweetCell.h"
#import "ComposeViewController.h"

@interface TimelineViewController () <ComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *tweetArray;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self getTweets];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(getTweets) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
     
}

- (void)getTweets {

        // Get timeline
        [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
            if (tweets) {
                
                self.tweetArray = (NSMutableArray *)tweets;
                
                NSLog(@"😎😎😎 Successfully loaded home timeline");
                
                
                NSLog(@"%@", self.tweetArray);
                
                [self.tableView reloadData];
                
            } else {
                NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
            }
            
            [self.refreshControl endRefreshing];
            
        }];
        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweetArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    
    Tweet *tweet = self.tweetArray[indexPath.row];
    
    cell.nameLabel.text = tweet.user.name;
    cell.usernameLabel.text = tweet.user.screenName;
    cell.dateLabel.text = tweet.createdAtString;
    cell.tweetContent.text = tweet.text;
    cell.likesCountLabel.text = [@(tweet.favoriteCount) stringValue];
    cell.retweetCountLabel.text = [@(tweet.retweetCount) stringValue];
    
    NSString *profileImageURLString = tweet.user.profileImageURLString;
    NSURL *profileImageURL = [NSURL URLWithString:profileImageURLString];
    [cell.profileImageView setImageWithURL:profileImageURL];
    
    cell.tweet = tweet;
    
    [cell refreshDataForLike];
    [cell refreshDataForRetweet];

    return cell;
}


- (void)didTweet:(Tweet *)tweet {
    [self.tweetArray insertObject:tweet atIndex:0];
    [self.tableView reloadData];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    UINavigationController *navigationController = [segue destinationViewController];
    ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
    composeController.delegate = self;
    
}



@end
