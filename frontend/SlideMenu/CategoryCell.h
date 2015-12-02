//
//  CategoryCell.h
//  Civi_Frontend_Zeqi
//
//  Created by Labuser on 11/22/15.
//  Copyright (c) 2015 Labuser. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryCell : UICollectionViewCell

@property (nonatomic, strong) UILabel* label;

-(void)setText:(NSString*)text;

-(void)setText:(NSString*)text withColor:(UIColor*)color;

@end
