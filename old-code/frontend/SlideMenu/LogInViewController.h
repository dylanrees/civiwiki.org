//
//  LogInViewController.h
//  CiviWiki
//
//  Created by Labuser on 11/22/15.
//  Copyright (c) 2015 wustl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogInViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;

- (IBAction)login:(id)sender;
- (IBAction)signup:(id)sender;
@end
