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
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "DateTools.h"
#import "TweetDetailsViewController.h"
#import "ProfileViewController.h"

@interface TimelineViewController () <ComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate, TweetCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *tweetArray;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end

@implementation TimelineViewController


- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}
 

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
            }
            else {
                NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
            }
            [self.refreshControl endRefreshing];
        
        }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweetArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // create tweet cell
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    Tweet *tweet = self.tweetArray[indexPath.row];
    [cell setTweet:tweet];
    cell.tweet = tweet;
    
    // update view labels for tweet
    cell.nameLabel.text = tweet.user.name;
    cell.usernameLabel.text = [@"@" stringByAppendingString:tweet.user.screenName];
    cell.dateLabel.text = tweet.createdAtString;
    cell.tweetContent.text = tweet.text;
    cell.likesCountLabel.text = [@(tweet.favoriteCount) stringValue];
    cell.retweetCountLabel.text = [@(tweet.retweetCount) stringValue];
    
    // update profile image for tweet
    NSString *profileImageURLString = tweet.user.profileImageURLString;
    NSURL *profileImageURL = [NSURL URLWithString:profileImageURLString];
    [cell.profileImageView setImageWithURL:profileImageURL];
    cell.profileImageView.layer.cornerRadius = cell.profileImageView.frame.size.height / 2;
    
    // refresh to update like and retweet status for tweet
    [cell refreshDataForLike];
    [cell refreshDataForRetweet];

    cell.delegate = self;
    return cell;
}


- (void)didTweet:(Tweet *)tweet {
    [self.tableView reloadData];
    [self getTweets];
    [self.tweetArray insertObject:tweet atIndex:0];
}

- (void)tweetCell:(TweetCell *)tweetCell didTap:(User *)user{
    [self.tableView reloadData];
    [self performSegueWithIdentifier:@"profileSegue" sender:user];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"composeSegue"]) {
        UINavigationController *navigationController = [segue destinationViewController];
        ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
        composeController.delegate = self;
    }
    
    else if ([segue.identifier isEqualToString:@"detailSegue"]){
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        Tweet *tweet = self.tweetArray[indexPath.row];
        
        TweetDetailsViewController *vc = [segue destinationViewController];
        vc.tweet = tweet;
    }
    
    else if ([segue.identifier isEqualToString:@"profileSegue"]){
        User *user = sender;
        ProfileViewController *profileViewController = [segue destinationViewController];
        profileViewController.currentUserID = user.userID;
    }

}



- (IBAction)didTapLogout:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginNavigationViewController"];
    appDelegate.window.rootViewController = loginViewController;
    
    [[APIManager shared] logout];
    
}



@end
