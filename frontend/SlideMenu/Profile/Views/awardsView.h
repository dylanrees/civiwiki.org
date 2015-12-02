//
//  awardsView.h
//  cw_user
//
//  Created by JL on 11/22/15.
//  Copyright © 2015 JL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface awardsView : UIViewController<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
}
@property (strong,nonatomic) NSMutableArray *awards;

-(id) initWithArray:(NSArray *) award_list;
@end
