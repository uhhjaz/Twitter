//
//  User.h
//  twitter
//
//  Created by Jasdeep Gill on 6/29/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject

// MARK: Properties
@property (nonatomic, strong) NSString *name; //name
@property (nonatomic, strong) NSString *screenName; //screen_name
@property (nonatomic, strong) NSString *profileImageURLString; //profile_image_url_https
@property (nonatomic, strong) NSString *descriptionTag; //description
@property (nonatomic, strong) NSString *followerCount; //followers_count
@property (nonatomic, strong) NSString *followingCount; //friends_count
@property (nonatomic, strong) NSString *retweetCount; //statuses_count
@property (nonatomic, strong) NSString *profileBannerURLString; //profile_banner_url
@property (nonatomic, strong) NSString *userID; //id_str

// MARK: Methods
+ (NSMutableArray *)userWithArray:(NSArray *)dictionaries;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;


@end

NS_ASSUME_NONNULL_END
