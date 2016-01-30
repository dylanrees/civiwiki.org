//
//  SignUpViewController.h
//  CiviWiki
//
//  Created by Labuser on 11/15/15.
//  Copyright (c) 2015 wustl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *fullNameText;
@property (weak, nonatomic) IBOutlet UITextField *usernameText;
@property (weak, nonatomic) IBOutlet UITextField *emailText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;

@end
