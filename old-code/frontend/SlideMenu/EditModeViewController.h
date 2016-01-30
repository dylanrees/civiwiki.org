//
//  ViewController.h
//  Civi_Frontend_Zeqi
//
//  Created by Labuser on 11/15/15.
//  Copyright (c) 2015 Labuser. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTBreadcrumbView.h"
#import "CategorySelectionViewController.h"
#import "ArticleSelectionViewController.h"
#import "CiviSelectionViewController.h"

@interface EditModeViewController : UIViewController <BTBreadcrumbViewDelegate, UICollectionViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *container;
@property (strong, nonatomic) CategorySelectionViewController *categoryVC;
@property (strong, nonatomic) ArticleSelectionViewController *articleVC;
@property (strong, nonatomic) CiviSelectionViewController *civiVC;
-(void)categoryTouch:(NSNumber*)index;
-(void)articleTouch:(NSNumber*)index;
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
-(void)civiTouch:(NSNumber*)index;
@end

