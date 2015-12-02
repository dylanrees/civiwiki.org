//
//  User.h
//  CiviWiki
//
//  Created by Labuser on 11/30/15.
//  Copyright © 2015 wustl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface LoginUser : NSObject

+ (LoginUser *) currentUser;

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSNumber *number;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) User *u;
/*
@property (nonatomic, strong) NSString *about_me;
@property (nonatomic, strong) NSString *stats;
@property (nonatomic, strong) NSString *profileImgString;
@property (nonatomic, strong) NSString *canvasImgString;
*/
@end
