//
//  Future.h
//  STRV_Forecast
//
//  Created by Simone Kalb on 21/01/15.
//  Copyright (c) 2015 Simone Kalb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Forecast;

@interface Future : NSManagedObject

@property (nonatomic, retain) NSString * date;
@property (nonatomic, retain) NSString * temperature_f;
@property (nonatomic, retain) NSString * temperature_c;
@property (nonatomic, retain) NSString * condition;
@property (nonatomic, retain) Forecast *futureForecast;
@property (nonatomic) int64_t weatherCode;

@end
