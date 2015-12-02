//
//  CategorySelectionViewController.h
//  Civi_Frontend_Zeqi
//
//  Created by Labuser on 11/20/15.
//  Copyright (c) 2015 Labuser. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryCell.h"
#import "SlideNavigationController.h"

@interface CategorySelectionViewController : UICollectionViewController<SlideNavigationControllerDelegate>

@property (nonatomic, strong) IBOutlet UISwitch *limitPanGestureSwitch;
@property (nonatomic, strong) IBOutlet UISwitch *slideOutAnimationSwitch;
@property (nonatomic, strong) IBOutlet UISwitch *shadowSwitch;
@property (nonatomic, strong) IBOutlet UISwitch *panGestureSwitch;
@property (nonatomic, strong) IBOutlet UISegmentedControl *portraitSlideOffsetSegment;
@property (nonatomic, strong) IBOutlet UISegmentedControl *landscapeSlideOffsetSegment;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UICollectionView *myView;
@property (strong, nonatomic) IBOutlet UINavigationController *myNav;
@property (strong, nonatomic) id notificationTarget;
@property(nonatomic, strong) NSArray *categories;
@property(nonatomic, strong) NSArray *categoriesP;



- (IBAction)bounceMenu:(id)sender;
- (IBAction)slideOutAnimationSwitchChanged:(id)sender;
- (IBAction)limitPanGestureSwitchChanged:(id)sender;
- (IBAction)changeAnimationSelected:(id)sender;
- (IBAction)shadowSwitchSelected:(id)sender;
- (IBAction)enablePanGestureSelected:(id)sender;
//- (IBAction)portraitSlideOffsetChanged:(id)sender;
- (IBAction)landscapeSlideOffsetChanged:(id)sender;
@end