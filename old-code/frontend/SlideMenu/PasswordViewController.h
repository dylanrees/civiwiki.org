//
//  PasswordViewController.h
//  CiviWiki
//
//  Created by Labuser on 11/22/15.
//  Copyright (c) 2015 wustl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PasswordViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *password;
- (IBAction)next:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnNext;

@end
