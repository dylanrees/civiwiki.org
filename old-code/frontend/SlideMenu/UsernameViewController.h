//
//  UsernameViewController.h
//  CiviWiki
//
//  Created by Labuser on 11/22/15.
//  Copyright (c) 2015 wustl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UsernameViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (strong, nonatomic) IBOutlet UILabel *lblVerify;

@end
