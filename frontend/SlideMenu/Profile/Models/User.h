//
//  User.h
//  cw_user
//
//  Created by JL on 11/20/15.
//  Copyright © 2015 JL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property NSString *username;
@property NSString *profileImgString;
@property NSString *canvasImgString;
@property NSString *first_name;
@property NSString *last_name;
@property NSString *email;
@property NSString *about_me;
@property NSMutableArray *friends;
@property NSMutableArray *awards;
@property NSMutableArray *history;
@property NSString *stats;

- (id) initDummy;
@end
