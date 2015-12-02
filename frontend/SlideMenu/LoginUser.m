//
//  User.m
//  CiviWiki
//
//  Created by Labuser on 11/30/15.
//  Copyright © 2015 wustl. All rights reserved.
//

#import "LoginUser.h"

@implementation LoginUser

+ (LoginUser *)currentUser
{
    static LoginUser *sharedInstance = nil;
    if (!sharedInstance)
    {
        sharedInstance = [[LoginUser alloc] init];
    }
    return sharedInstance;
}

@end
