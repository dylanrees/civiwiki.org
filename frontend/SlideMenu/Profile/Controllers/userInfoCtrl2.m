//
//  userInfoCtrl2.m
//  cw_user
//
//  Created by JL on 11/22/15.
//  Copyright © 2015 JL. All rights reserved.
//

#import "userInfoCtrl2.h"
#import "historyView.h"

@interface userInfoCtrl2 ()
{
    int viewMode;
}
@property (strong, nonatomic) UISegmentedControl *segmentedControl;
@property (strong, nonatomic) UILabel *label_pinned;
@property (strong, nonatomic) UILabel *label_stats;
@property (strong, nonatomic) historyView *table;
@end

@implementation userInfoCtrl2
@synthesize segmentedControl;
@synthesize user;
@synthesize label_pinned;
@synthesize table;
@synthesize label_stats;

- (id) init {
    self = [super init];
    if (self)
    {
        //test = @"not working";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    viewMode = 0;
    
    self.view.backgroundColor = [UIColor whiteColor];//[UIColor greenColor];
    
    segmentedControl = [[UISegmentedControl alloc]initWithItems:@[@"Pinned",@"History",@"Stats"]];
    segmentedControl.frame = CGRectMake(10, 10, 300, 30);
    segmentedControl.tintColor =[UIColor colorWithRed:58/255.0 green:2/255.0 blue:86/255.0 alpha:0.80];
    [segmentedControl addTarget:self action:@selector(segmentedControlValueDidChange:) forControlEvents:UIControlEventValueChanged];
    [segmentedControl setSelectedSegmentIndex:0];
    
    
    label_pinned = [[UILabel alloc] initWithFrame:CGRectMake(40, segmentedControl.frame.origin.y, 295, 200)];
    label_pinned.text = @"Pinned Civi";
    label_pinned.backgroundColor = [UIColor whiteColor];
    label_pinned.font = [UIFont fontWithName:@"System" size:12];
    label_pinned.textColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1.00];
    label_pinned.textAlignment = NSTextAlignmentLeft;
    label_pinned.lineBreakMode = NSLineBreakByWordWrapping;
    label_pinned.numberOfLines = 0;
    [label_pinned sizeToFit];
    label_pinned.frame = CGRectMake(20, 50, label_pinned.frame.size.width, label_pinned.frame.size.height);
    [self.view addSubview:label_pinned];
    
    label_stats = [[UILabel alloc] initWithFrame:CGRectMake(40, segmentedControl.frame.size.height, 295, 200)];
    label_stats.text = user.stats;
    label_stats.backgroundColor = [UIColor clearColor];
    label_stats.font = [UIFont fontWithName:@"System" size:12];
    label_stats.textColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1.00];
    label_stats.textAlignment = NSTextAlignmentLeft;
    label_stats.lineBreakMode = NSLineBreakByWordWrapping;
    label_stats.numberOfLines = 0;
    [label_stats sizeToFit];
    label_stats.frame = CGRectMake(20, 50, label_stats.frame.size.width, label_stats.frame.size.height);
    [self.view addSubview:label_stats];
    label_stats.hidden = YES;
    
    
    table = [[historyView alloc] initWithArray:user.history];
    [self.view addSubview: table.view];
    table.view.hidden=YES;
    
    
    [self.view addSubview:segmentedControl];
    
    [self resizeToFitSubviews];
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"SizeChangeNotification2"
     object:self];
    
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
            label_pinned.hidden = NO;
            table.view.hidden = YES;
            label_stats.hidden = YES;
            [self resizeToFitSubviews];
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"SizeChangeNotification2"
             object:self];
            break;}
        case 1:{
            viewMode = 1;
            label_pinned.hidden = YES;
            table.view.hidden = NO;
            label_stats.hidden= YES;
            [self resizeToFitSubviews];
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"SizeChangeNotification2"
             object:self];
            break;}
        case 2:{
            viewMode = 2;
            label_pinned.hidden = YES;
            table.view.hidden = YES;
            label_stats.hidden = NO;
            [self resizeToFitSubviews];
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"SizeChangeNotification2"
             object:self];
            break;}
    }
    NSLog(@"View in Container2 changed to: %d", viewMode);
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
