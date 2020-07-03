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
        self.profileImageURLString = [dictionary[@"profile_image_url_https"] stringByReplacingOccurrencesOfString:@"_normal" withString:@""];
        self.descriptionTag = dictionary[@"description"];

        self.followerCount = [self suffixNumber:dictionary[@"followers_count"]];
        self.followingCount = [self suffixNumber:dictionary[@"friends_count"]];
        self.retweetCount = [self suffixNumber:dictionary[@"statuses_count"]];
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

-(NSString*) suffixNumber:(NSNumber*)number{
    if (!number) {
        return @"";
    }
    long long num = [number longLongValue];
    int s = ( (num < 0) ? -1 : (num > 0) ? 1 : 0 );
    
    NSString* sign = (s == -1 ? @"-" : @"" );
    num = llabs(num);

    if (num < 1000) {
        return [NSString stringWithFormat:@"%@%lld",sign,num];
    }
    
    int exp = (int) (log10l(num) / 3.f);

    NSArray* units = @[@"K",@"M"];

    return [NSString stringWithFormat:@"%@%.1f%@",sign, (num / pow(1000, exp)), [units objectAtIndex:(exp-1)]];
}

@end
