//
//  CategoryCell.m
//  Civi_Frontend_Zeqi
//
//  Created by Labuser on 11/22/15.
//  Copyright (c) 2015 Labuser. All rights reserved.
//

#import "CategoryCell.h"

@implementation CategoryCell

-(void)setText:(NSString*) text
{
	[self setText:text withColor:[UIColor blackColor]];
}

-(void)setText:(NSString*)text withColor:(UIColor *)color
{
	[self.label removeFromSuperview];
	self.label = [[UILabel alloc] initWithFrame:[[self contentView] frame]];
	[self.label setNumberOfLines:0];
	[self.label setText:text];
	[self.label setTextColor:color];
	[self.contentView addSubview:self.label];
}
@end
