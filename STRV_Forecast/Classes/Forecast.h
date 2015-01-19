//
//  Forecast.h
//  STRV_Forecast
//
//  Created by Simone Kalb on 19/01/15.
//  Copyright (c) 2015 Simone Kalb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Forecast : NSManagedObject

@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * temperature_c;
@property (nonatomic, retain) NSString * temperature_f;
@property (nonatomic, retain) NSString * condition;
@property (nonatomic, retain) NSString * chance_rain;
@property (nonatomic, retain) NSString * precipitation;
@property (nonatomic, retain) NSString * pressure;
@property (nonatomic, retain) UNKNOWN_TYPE wind_speed_km;
@property (nonatomic, retain) UNKNOWN_TYPE wind_speed_mi;
@property (nonatomic, retain) NSString * wind_direction;

@end
