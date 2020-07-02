//
//  ProfileViewController.h
//  twitter
//
//  Created by Jasdeep Gill on 7/1/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN



@interface ProfileViewController : UIViewController

@property (nonatomic, strong) NSString *currentUserID;

- (void)getViewData;

@end


NS_ASSUME_NONNULL_END
