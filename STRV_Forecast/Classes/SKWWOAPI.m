//
//  SKWWOAPI.m
//  World Weather Online API Support Class:
//  It queries the online service and send the correct answer to the JSON parser
//  STRV_Forecast
//
//  Created by Simone Kalb on 19/01/15.
//  Copyright (c) 2015 Simone Kalb. All rights reserved.
//

#import "SKWWOAPI.h"
#import "Forecast.h"
#import "City.h"

#define API_KEY @"8078210c20e2d625bb0157b622cce"

@implementation SKWWOAPI

-(id)init {
    if(!self) {
        self = [super init];
    }
    return self;
}
    
-(void)forwardRequest:(NSString *)cityName {
    
    WorldWeatherOnline *wwo = [[WorldWeatherOnline alloc] initWithApiKey:API_KEY];
    wwo.delegate = self;
    
    // Lookup info for a specific city
//    [wwo searchLocation:@"London"];
    
    // Request local weather data by a city name
    [wwo getWeather:cityName];
    
}

- (void)requestFailed:(NSString *)message {
    
    NSLog(@"Error: %@", message);
}

- (void)requestSucces:(NSDictionary *)data {
    
    NSLog(@"--------------------------------\n\n");
    NSLog(@"Current Condition for %@", data[@"request"][0][@"query"]);
    NSLog(@"Current Temperature in C: %@", data[@"current_condition"][0][@"temp_C"]);
    NSLog(@"Current Temperature in F: %@", data[@"current_condition"][0][@"temp_F"]);
    NSLog(@"Type of condition: %@", data[@"current_condition"][0][@"weatherDesc"][0][@"value"]);
    NSLog(@"Chance of rain: %@", data[@"weather"][0][@"hourly"][0][@"chanceofrain"]
          );
    NSLog(@"Precipitation in mm: %@", data[@"current_condition"][0][@"precipMM"]);
    NSLog(@"Atmospheric Pressure: %@", data[@"weather"][0][@"hourly"][0][@"pressure"]);
    NSLog(@"Wind Speed KM: %@", data[@"current_condition"][0][@"windspeedKmph"]);
    NSLog(@"Wind Speed Miles: %@", data[@"current_condition"][0][@"windspeedMiles"]);
    NSLog(@"Wind Direction: %@", data[@"current_condition"][0][@"winddir16Point"]);
    
    /* Create items in the database for current location weather */
    Forecast *currentForecast = [Forecast MR_createEntity];
    
    currentForecast.city = data[@"request"][0][@"query"];
    currentForecast.temperature_c = data[@"current_condition"][0][@"temp_C"];
    currentForecast.temperature_f = data[@"current_condition"][0][@"temp_F"];
    currentForecast.condition = data[@"current_condition"][0][@"weatherDesc"][0][@"value"];
    currentForecast.chance_rain = data[@"weather"][0][@"hourly"][0][@"chanceofrain"];
    currentForecast.precipitation = data[@"current_condition"][0][@"precipMM"];
    currentForecast.pressure = data[@"weather"][0][@"hourly"][0][@"pressure"];
    currentForecast.wind_speed_km = data[@"current_condition"][0][@"windspeedKmph"];
    currentForecast.wind_speed_mi = data[@"current_condition"][0][@"windspeedMiles"];
    currentForecast.wind_direction = data[@"current_condition"][0][@"winddir16Point"];
    
    // Remember to initialize all other cities to NO
    currentForecast.isCurrent = YES;
    
    /*
    currentForecast.relationship.latitude =
    currentForecast.relationship.longitude =
    */
    
    [SETTINGS saveContext];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:CURRENT_FORECAST object:nil];
}
    
@end
