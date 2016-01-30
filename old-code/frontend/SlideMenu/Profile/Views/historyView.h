//
//  historyView.h
//  cw_user
//
//  Created by JL on 11/22/15.
//  Copyright © 2015 JL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface historyView : UITableViewController

@property (strong,nonatomic) NSMutableArray *history;

-(id) initWithArray:(NSMutableArray *) history_list;
@end
