//
//  userInfoCtrl1.m
//  cw_user
//
//  Created by JL on 11/22/15.
//  Copyright © 2015 JL. All rights reserved.
//

#import "userInfoCtrl1.h"

@interface userInfoCtrl1 ()
{
    int viewMode;
}
@property (strong, nonatomic) UISegmentedControl *segmentedControl;
@property (strong, nonatomic) UILabel *label_about_me;
@property (strong, nonatomic) awardsView *awards;
@property (strong, nonatomic) friendsView *friends;
@end

@implementation userInfoCtrl1
@synthesize segmentedControl;
@synthesize label_about_me;
@synthesize user;
@synthesize about_me;
@synthesize awards;
@synthesize friends;

- (id) init {
    self = [super init];
    if (self)
    {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    viewMode = 0;
    self.view.backgroundColor = [UIColor whiteColor];
    
    // About Me Setup
    label_about_me = [[UILabel alloc] initWithFrame:CGRectMake(40, segmentedControl.frame.origin.y + 10, 295, 200)];
    label_about_me.text = about_me;
    label_about_me.backgroundColor = [UIColor whiteColor];
    label_about_me.font = [UIFont fontWithName:@"System" size:12];
    label_about_me.textColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1.00];
    label_about_me.textAlignment = NSTextAlignmentLeft;
    label_about_me.lineBreakMode = NSLineBreakByWordWrapping;
    label_about_me.numberOfLines = 0;
    [label_about_me sizeToFit];
    label_about_me.frame = CGRectMake(20, 50, label_about_me.frame.size.width, label_about_me.frame.size.height);
    [self.view addSubview:label_about_me];
    
    // Awards Setup
    awards = [[awardsView alloc]initWithArray:user.awards];
    [awards.view sizeToFit];
    [self.view addSubview:awards.view];
    awards.view.hidden = YES;
    
    
    // Friends Setup
    friends = [[friendsView alloc]initWithArray:user.friends];
    //awards.view.frame =
    [friends.view sizeToFit];
    [self.view addSubview:friends.view];
    friends.view.hidden = YES;
    
    
    // Segmented Control bar setup
    segmentedControl = [[UISegmentedControl alloc]initWithItems:@[@"About",@"Awards",@"Friends"]];
    segmentedControl.frame = CGRectMake(10, 10, 300, 30);
    segmentedControl.tintColor =[UIColor colorWithRed:58/255.0 green:2/255.0 blue:86/255.0 alpha:0.80];
    [segmentedControl addTarget:self action:@selector(segmentedControlValueDidChange:) forControlEvents:UIControlEventValueChanged];
    [segmentedControl setSelectedSegmentIndex:0];
    [self.view addSubview:segmentedControl];
    
    // Now that all views have been added, resize the view appropriately and send a notification to the main view
    [self resizeToFitSubviews];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SizeChangeNotification" object:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
-(void)segmentedControlValueDidChange
Handles segmented bar input and hides/shows appropriate views while notifying the main view controller of the view size change
 */
-(void)segmentedControlValueDidChange:(UISegmentedControl *)segment
{
    switch (segment.selectedSegmentIndex) {
        case 0:{
            viewMode = 0;
            label_about_me.hidden = NO;
            awards.view.hidden = YES;
            friends.view.hidden = YES;
            [self resizeToFitSubviews];
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"SizeChangeNotification"
             object:self];
            break;}
        case 1:{
            viewMode = 1;
            label_about_me.hidden = YES;
            awards.view.hidden = NO;
            friends.view.hidden = YES;
            [self resizeToFitSubviews];
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"SizeChangeNotification"
             object:self];
            break;}
        case 2:{
            viewMode = 2;
            label_about_me.hidden = YES;
            awards.view.hidden = YES;
            friends.view.hidden = NO;
            [self resizeToFitSubviews];
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"SizeChangeNotification"
             object:self];
            break;}
    }
    NSLog(@"View in Container1 changed to: %d", viewMode);
}

/* 
 -(void)resizeToFitSubviews()
 Resizes the view height to account for all elements as the sections change
 */
-(void)resizeToFitSubviews
{
    float w = 0;
    float h = 0;
    
    for (UIView *v in [self.view subviews]) {
        if (v.hidden == NO){
            float fw = v.frame.origin.x + v.frame.size.width;
            float fh = v.frame.origin.y + v.frame.size.height;
            w = MAX(fw, w);
            h = MAX(fh, h);
        }
    }
    if (h < 195){
        h = 195;
    }
    
    [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, h)];
}


@end
