//
//  userInfoCtrl1.h
//  cw_user
//
//  Created by JL on 11/22/15.
//  Copyright © 2015 JL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileViewController.h"
#import "User.h"
#import "awardsView.h"
#import "friendsView.h"

@interface userInfoCtrl1 : UIViewController
@property (strong, nonatomic) User *user;
@property (strong, nonatomic) NSString *about_me;
@end
