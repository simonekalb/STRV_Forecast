//
//  City.h
//  STRV_Forecast
//
//  Created by Simone Kalb on 30/01/15.
//  Copyright (c) 2015 Simone Kalb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Forecast;

@interface City : NSManagedObject

@property (nonatomic, retain) NSString * latitude;
@property (nonatomic, retain) NSString * longitude;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * state;
@property (nonatomic, retain) NSString * weatherURL;
@property (nonatomic, retain) NSSet *forecast;
@end

@interface City (CoreDataGeneratedAccessors)

- (void)addForecastObject:(Forecast *)value;
- (void)removeForecastObject:(Forecast *)value;
- (void)addForecast:(NSSet *)values;
- (void)removeForecast:(NSSet *)values;

@end
