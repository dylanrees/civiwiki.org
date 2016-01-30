//
//  NameViewController.h
//  CiviWiki
//
//  Created by Labuser on 11/22/15.
//  Copyright (c) 2015 wustl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NameViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
- (IBAction)next:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnNext;

@end
