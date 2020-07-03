//
//  APIManager.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "APIManager.h"
#import "Tweet.h"

static NSString * const baseURLString = @"https://api.twitter.com";
static NSString * const consumerKey = @"AsY5BuAPXrzUPmnyTe0en9EBR";
static NSString * const consumerSecret = @"9aiLwKej77fTrRe8pccIQudaFG4fHl0CFoAIDH7UPQ0h2vUbJe";
static NSString * const GET_HOME_TIMELINE = @"1.1/statuses/home_timeline.json?tweet_mode=extended";
static NSString * const POST_STATUS = @"1.1/statuses/update.json";
static NSString * const POST_FAVORITE = @"1.1/favorites/create.json";
static NSString * const POST_UNFAVORITE = @"1.1/favorites/destroy.json";
static NSString * const POST_RETWEET = @"1.1/statuses/retweet.json";
static NSString * const POST_UNRETWEET = @"1.1/statuses/unretweet.json";
static NSString * const GET_USER_SELF = @"1.1/account/verify_credentials.json";
static NSString * const GET_USER = @"1.1/users/show.json";


@interface APIManager()

@end

@implementation APIManager


+ (instancetype)shared {
    static APIManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}


- (instancetype)init {
    
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSString *key = consumerKey;
    NSString *secret = consumerSecret;
    
    // Check for launch arguments override
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"consumer-key"]) {
        key = [[NSUserDefaults standardUserDefaults] stringForKey:@"consumer-key"];
    }
    
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"consumer-secret"]) {
        secret = [[NSUserDefaults standardUserDefaults] stringForKey:@"consumer-secret"];
    }
    
    self = [super initWithBaseURL:baseURL consumerKey:key consumerSecret:secret];
    if (self) {
        
    }
    return self;
}


- (void)getHomeTimelineWithCompletion:(void(^)(NSArray *tweets, NSError *error))completion {
    
    // Create a GET Request
    [self GET:GET_HOME_TIMELINE
        parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray *  _Nullable tweetDictionaries) {
            // Success
            NSMutableArray *tweets  = [Tweet tweetsWithArray:tweetDictionaries];
            completion(tweets, nil);
        
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            // There was a problem
            completion(nil, error);
    }];
    
}


- (void)getMyProfile:(void(^)(User *theUser, NSError *error))completion {
    
    // Create a GET Request
    [self GET:GET_USER_SELF
        parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable userDictionary) {
            // Success
            User *user  = [[User alloc] initWithDictionary:userDictionary];
            NSLog(@"%@",user);
            completion(user, nil);
        
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            // There was a problem
            completion(nil, error);
    }];
}


- (void)getUserProfile:(NSString *)idString completion:(void(^)(User *theUser, NSError *error))completion {
    
    NSDictionary *parameters = @{@"id": idString};
    // Create a GET Request
    [self GET:GET_USER
        parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable userDictionary) {
            // Success
            User *user  = [[User alloc] initWithDictionary:userDictionary];
            NSLog(@"%@",user);
            completion(user, nil);
        
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            // There was a problem
            completion(nil, error);
    }];
}


- (void)postStatusWithText:(NSString *)text completion:(void (^)(Tweet *, NSError *))completion{
    NSString *urlString = POST_STATUS;
    NSDictionary *parameters = @{@"status": text};
    
    [self POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable tweetDictionary) {
        Tweet *tweet = [[Tweet alloc]initWithDictionary:tweetDictionary];
        completion(tweet, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}


- (void)updateTweetStatus:(Tweet *)tweet :(NSString *)urlString completion:(void (^)(Tweet *, NSError *))completion {
    NSDictionary *parameters = @{@"id": tweet.idStr};
    
    [self POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable tweetDictionary) {
        Tweet *tweet = [[Tweet alloc]initWithDictionary:tweetDictionary];
        completion(tweet, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}


@end
