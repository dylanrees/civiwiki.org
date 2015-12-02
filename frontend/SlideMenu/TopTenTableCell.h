//
//  TopTenTableCell.h
//  CiviFeediPhone
//
//  Created by Labuser on 12/1/15.
//  Copyright (c) 2015 wustl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopTenTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *CiviTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *CiviViewsLabel;
@property (weak, nonatomic) IBOutlet UILabel *CiviAuthorLabel;

@end
