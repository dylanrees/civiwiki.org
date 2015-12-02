//
//  User.m
//  cw_user
//
//  Created by JL on 11/20/15.
//  Copyright © 2015 JL. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize username;
@synthesize about_me;
@synthesize profileImgString;
@synthesize canvasImgString;
@synthesize friends;
@synthesize awards;
@synthesize history;
@synthesize first_name;
@synthesize last_name;
@synthesize stats;

- (id) init
{
    self = [super init];
    return self;
}

- (id) initDummy
{
    self = [self init];
    if (self)
    {
        self.username = @"Dummy";
        self.first_name = @"dummy";
        self.last_name = @"user";
        self.about_me = @"Hi im a dummy user for testing purposes. Testing multiple lines. Testing other things. Test test test test test test test test test test test test test test test test test test test test test test";
        self.profileImgString = @"profile.png";
        self.canvasImgString = @"canvas.png";
        self.friends = [[NSMutableArray alloc]init];
        self.awards = [[NSMutableArray alloc]init];
        self.friends = [[NSArray arrayWithObjects:@"user1", @"user2",@"user3",@"user4",@"user5",nil]mutableCopy];
        self.awards = [[NSArray arrayWithObjects:@"YAY", @"NICE",@"GOODJOB",@"HOORAY",@"AWARD",@"100 DAYS", @"$$$", @"POWER", @"WHOO!",nil]mutableCopy];
        self.history = [[NSMutableArray alloc]
                        initWithObjects:@"A very interesting civi", @"Civi with lots of media", @"A random civi", @"Most popular civi", @"Civi about immigration",@"Controversial Civi", @"Personal civi with an agenda", @"Extra civi lying around", @"Everyone-agrees-with-this civi", @"Last civi",nil];
        self.
        self.stats = @"Stats";
        
    }
    return self;
}

@end
