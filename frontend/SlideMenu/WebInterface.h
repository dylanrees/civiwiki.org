//
//  WebInterface.h
//  Civi_Frontend_Zeqi
//
//  Created by Aaron Graubert on 11/28/15.
//  Copyright (c) 2015 Labuser. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebInterface : NSObject

+(NSMutableArray*)JSONDataFromUrl:(NSString*)url withPOST:(NSString*)post;
+(NSArray*)JSONDataFromUrl:(NSString*)url;
@end
