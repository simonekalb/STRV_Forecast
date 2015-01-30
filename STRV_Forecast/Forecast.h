//
//  Forecast.h
//  STRV_Forecast
//
//  Created by Simone Kalb on 30/01/15.
//  Copyright (c) 2015 Simone Kalb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class City;

@interface Forecast : NSManagedObject

@property (nonatomic, retain) NSString * chance_rain;
@property (nonatomic, retain) NSString * condition;
@property (nonatomic, retain) NSString * date;
@property (nonatomic) BOOL isCurrent;
@property (nonatomic) BOOL isGeolocate;
@property (nonatomic, retain) NSString * precipitation;
@property (nonatomic, retain) NSString * pressure;
@property (nonatomic, retain) NSString * temperature_c;
@property (nonatomic, retain) NSString * temperature_f;
@property (nonatomic) int64_t weatherCode;
@property (nonatomic, retain) NSString * wind_direction;
@property (nonatomic, retain) NSString * wind_speed_km;
@property (nonatomic, retain) NSString * wind_speed_mi;
@property (nonatomic, retain) City *city;

@end
