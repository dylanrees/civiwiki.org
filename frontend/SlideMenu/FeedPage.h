//
//  FeedPage.h
//  CiviFeed-Shefali
//
//  Created by Labuser on 11/15/15.
//  Copyright (c) 2015 wustl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedPage : UIViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (strong, nonatomic) NSString *heading;
@property (strong, nonatomic) UIScrollView *scrollText;

@property (strong, nonatomic) UILabel *body;
@property (strong, nonatomic) UILabel *author;
@property (strong, nonatomic) UILabel *visits;
@property (strong, nonatomic) UILabel *articleTitle;

@property (strong, nonatomic) UIToolbar *ratingsBar;
@property (strong, nonatomic) NSArray *ratingsItems;

@property (strong, nonatomic) IBOutlet UIToolbar *tools;
@property (strong, nonatomic) IBOutlet UIButton *ratingNegTwo;
@property (strong, nonatomic) IBOutlet UIButton *ratingNegOne;
@property (strong, nonatomic) IBOutlet UIButton *ratingZero;
@property (strong, nonatomic) IBOutlet UIButton *ratingPosOne;
@property (strong, nonatomic) IBOutlet UIButton *ratingPosTwo;



@end
