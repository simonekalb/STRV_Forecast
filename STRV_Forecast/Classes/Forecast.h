//
//  Forecast.h
//  STRV_Forecast
//
//  Created by Simone Kalb on 20/01/15.
//  Copyright (c) 2015 Simone Kalb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class City, Future;

@interface Forecast : NSManagedObject

@property (nonatomic, retain) NSString * chance_rain;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * condition;
@property (nonatomic, retain) NSString * precipitation;
@property (nonatomic, retain) NSString * pressure;
@property (nonatomic, retain) NSString * temperature_c;
@property (nonatomic, retain) NSString * temperature_f;
@property (nonatomic, retain) NSString * wind_direction;
@property (nonatomic, retain) NSString * wind_speed_km;
@property (nonatomic, retain) NSString * wind_speed_mi;

@property (nonatomic, retain) Future * future;
@property (nonatomic, retain) City *relationship;

@property (nonatomic) BOOL isCurrent;

@end
