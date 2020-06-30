//
//  ComposeViewController.m
//  twitter
//
//  Created by Jasdeep Gill on 6/29/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"
#import "Tweet.h"

@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *composeTweetView;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)cancelComposeAction:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)tweetAction:(id)sender {
    NSString *tweetContent = self.composeTweetView.text;
    
    [[APIManager shared] postStatusWithText:tweetContent completion:^(Tweet *tweets, NSError *error) {
    
        if (tweets) {
        
            [self dismissViewControllerAnimated:true completion:nil];
            [self.delegate didTweet:tweets];
            NSLog(@"😎😎😎 Successfully posted tweet");
        
        } else {
            
            NSLog(@"😫😫😫 Error posting tweet: %@", error.localizedDescription);
        }
        
    }];
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
