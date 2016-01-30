//
//  NumberViewController.h
//  CiviWiki
//
//  Created by Labuser on 11/22/15.
//  Copyright (c) 2015 wustl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NumberViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *number;
- (IBAction)next:(id)sender;

@end
