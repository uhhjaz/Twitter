//
//  User.m
//  twitter
//
//  Created by Jasdeep Gill on 6/29/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "User.h"

@implementation User


- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
   
    if (self) {
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        NSLog(@"%@", self.name);
        // Initialize any other properties
        self.profileImageURLString = dictionary[@"profile_image_url_https"];
        self.descriptionTag = dictionary[@"description"];

        self.followerCount = [dictionary[@"followers_count"] stringValue];
        self.followingCount = [dictionary[@"friends_count"] stringValue];
        self.retweetCount = [dictionary[@"statuses_count"] stringValue];
        self.profileBannerURLString = dictionary[@"profile_banner_url"];
        self.userID = dictionary[@"id_str"];
        NSLog(@"%@", self.userID);
        NSLog(@"%@", self.screenName);
        
    }
    return self;
}

+ (NSMutableArray *)userWithArray:(NSArray *)dictionaries {
    NSMutableArray *users = [NSMutableArray array];
    for (NSDictionary *dictionary in dictionaries) {
        User *userDictionary = [[User alloc] initWithDictionary:dictionary];
        [users addObject:userDictionary];
    }
    return users;
}

@end
