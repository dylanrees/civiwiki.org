//
//  ArticleSelectionViewController.h
//  Civi_Frontend_Zeqi
//
//  Created by Labuser on 11/22/15.
//  Copyright (c) 2015 Labuser. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleCell.h"

@interface ArticleSelectionViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UITableView *myView;
@property (strong, nonatomic) id notificationTarget;
@property(nonatomic, strong) NSArray *articles;
@property (strong, nonatomic) NSMutableArray *intakeData;

-(void)reloadUsingCategory:(NSString*)category;
@end
