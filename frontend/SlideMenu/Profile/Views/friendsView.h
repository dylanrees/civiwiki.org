//
//  friendsView.h
//  cw_user
//
//  Created by JL on 11/22/15.
//  Copyright © 2015 JL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface friendsView : UIViewController<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
}
@property (strong,nonatomic) NSMutableArray *friends;

-(id) initWithArray:(NSMutableArray *) friend_list;
@end
