//
//  SKQueryBuilder.h
//  STRV_Forecast
//
//  Created by Simone Kalb on 19/01/15.
//  Copyright (c) 2015 Simone Kalb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SKQueryBuilder : NSObject

@property(strong, nonatomic) NSString *key;
@property(strong, nonatomic) NSString *location;
@property(strong, nonatomic) NSString *format;
@property(strong, nonatomic) NSNumber *numOfDays;
@end
