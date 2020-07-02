//
//  ProfileViewController.m
//  twitter
//
//  Created by Jasdeep Gill on 7/1/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "ProfileViewController.h"
#import "User.h"
#import "APIManager.h"
#import "ProfileView.h"
#import "UIImageView+AFNetworking.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet ProfileView *profileView;
@property (strong, nonatomic) User *theUser;
@end


@implementation ProfileViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[APIManager shared] getUserProfile:^(User *theUser, NSError *error) {
        if (theUser) {
            NSLog(@"😎😎😎 Successfully loaded home timeline");

            self.theUser = theUser;
            [self getViewData];
        }
        else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];
}


- (void)getViewData {
    
    self.profileView.nameLabel.text = self.theUser.name;
    self.profileView.usernameLabel.text = [@"@" stringByAppendingString:self.theUser.screenName];
    self.profileView.taglineContent.text = self.theUser.descriptionTag;
    self.profileView.followingCount.text = self.theUser.followingCount;
    self.profileView.followerCount.text = self.theUser.followerCount;
    self.profileView.tweetCount.text = self.theUser.retweetCount;
    
    // update header image for user
    NSString *headerImageURLString = self.theUser.profileBannerURLString;
    NSLog(@"%@",headerImageURLString);
    NSURL *headerImageURL = [NSURL URLWithString:headerImageURLString];
    [self.profileView.headerImageView setImageWithURL:headerImageURL];
    
    // update profile image for user
    NSString *profileImageURLString = self.theUser.profileImageURLString;
    NSLog(@"%@",profileImageURLString);
    NSURL *profileImageURL = [NSURL URLWithString:profileImageURLString];
    [self.profileView.defaultPictureView setImageWithURL:profileImageURL];
    
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
