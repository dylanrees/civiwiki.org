//
//  CiviSelectionViewController.h
//  Civi_Frontend_Zeqi
//
//  Created by Aaron Graubert on 11/28/15.
//  Copyright (c) 2015 Labuser. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CiviSelectionViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *myView;
@property (strong, nonatomic) IBOutlet UICollectionView *myCollection;
@property (strong, nonatomic) IBOutlet UITextView *myText;
@property (strong, nonatomic) id notificationTarget;
@property (strong, nonatomic) NSNumber* selectionMode;
@property (strong, nonatomic) NSMutableDictionary* civis;
@property (strong, nonatomic) NSString* lastArticle;
@property (strong, nonatomic) NSMutableArray* selections;
//@property (strong, nonatomic) IBOutlet UIScreenEdgePanGestureRecognizer *Swipe;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *rightSwipe;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *leftSwipe;

-(void)reloadWithArticle:(NSString*)article atLevel:(NSInteger)depth;
-(void)reloadWithArticle:(NSString*)article atLevel:(NSInteger)depth andCenter:(NSString*)center;
@end
