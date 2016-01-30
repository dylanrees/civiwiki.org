//
//  TopTenTable.h
//  CiviFeediPhone
//
//  Created by Labuser on 11/29/15.
//  Copyright (c) 2015 wustl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"

@interface TopTenTable : UITableViewController <SlideNavigationControllerDelegate>
{
}

@property (strong, nonatomic) UINavigationBar *navBar;
@property(strong, nonatomic) UIColor *barTintColor;



@property (nonatomic, strong) IBOutlet UISwitch *limitPanGestureSwitch;
@property (nonatomic, strong) IBOutlet UISwitch *slideOutAnimationSwitch;
@property (nonatomic, strong) IBOutlet UISwitch *shadowSwitch;
@property (nonatomic, strong) IBOutlet UISwitch *panGestureSwitch;
@property (nonatomic, strong) IBOutlet UISegmentedControl *portraitSlideOffsetSegment;
@property (nonatomic, strong) IBOutlet UISegmentedControl *landscapeSlideOffsetSegment;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

- (IBAction)bounceMenu:(id)sender;
- (IBAction)slideOutAnimationSwitchChanged:(id)sender;
- (IBAction)limitPanGestureSwitchChanged:(id)sender;
- (IBAction)changeAnimationSelected:(id)sender;
- (IBAction)shadowSwitchSelected:(id)sender;
- (IBAction)enablePanGestureSelected:(id)sender;
//- (IBAction)portraitSlideOffsetChanged:(id)sender;
- (IBAction)landscapeSlideOffsetChanged:(id)sender;
@end
