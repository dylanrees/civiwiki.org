//
//  ViewController.h
//  cw_user
//
//  Created by JL on 11/20/15.
//  Copyright © 2015 JL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "userInfoCtrl1.h"
#import "userInfoCtrl2.h"
#import "SlideNavigationController.h"

@interface ProfileViewController : UIViewController  <SlideNavigationControllerDelegate>

@property (strong, nonatomic) User *user;

-(void) refresh;
- (void) deallocObservers;
@end

