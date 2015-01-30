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
    
    // Request local weather data by a city name
    [wwo getWeather:cityName];
    
}

- (void)requestFailed:(NSString *)message {
    
    // TODO - Fix With HUD
    NSLog(@"Error: %@", message);
}

- (void)requestSucces:(NSDictionary *)data {
    
    // Make sure that the city doesn't exist yet
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@",
                              data[@"request"][0][@"query"]];
    NSArray *alreadyAdded = [City MR_findAllWithPredicate:predicate];
    
    if([alreadyAdded count] > 0) {
//        [self removePreviousWeatherForCity:alreadyAdded[0]];
        [self updateWeatherForCity:(City *)alreadyAdded[0] withDate:(NSDictionary *)data];
    } else {
        // Create a new City
        City *newCity = [City MR_createEntity];
        newCity.name = data[@"request"][0][@"query"];
        [self updateWeatherForCity:(City *)newCity withDate:(NSDictionary *)data];
    }
    
    
    [SETTINGS saveContext];
    [[NSNotificationCenter defaultCenter] postNotificationName:CURRENT_FORECAST object:nil];
}


-(void)updateWeatherForCity:(City *)newCity withDate:(NSDictionary *)data {

    // Forecast for today
    Forecast *currentForecast = [Forecast MR_createEntity];
    NSDictionary *dataEndPoint = data[@"current_condition"][0];
    currentForecast.city = data[@"request"][0][@"query"];
    currentForecast.temperature_c = dataEndPoint[@"temp_C"];
    currentForecast.temperature_f = dataEndPoint[@"temp_F"];
    currentForecast.condition = dataEndPoint[@"weatherDesc"][0][@"value"];
    currentForecast.chance_rain = data[@"weather"][0][@"hourly"][0][@"chanceofrain"];
    currentForecast.precipitation = dataEndPoint[@"precipMM"];
    currentForecast.pressure = data[@"weather"][0][@"hourly"][0][@"pressure"];
    currentForecast.wind_speed_km = dataEndPoint[@"windspeedKmph"];
    currentForecast.wind_speed_mi = dataEndPoint[@"windspeedMiles"];
    currentForecast.wind_direction = dataEndPoint[@"winddir16Point"];
    currentForecast.weatherCode = [dataEndPoint[@"weatherCode"] longLongValue];
    
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    // Setting today's date
    //    currentForecast.date = [dateFormatter stringFromDate:[NSDate date]];
    
    // This is not going to work as in
    // http://stackoverflow.com/questions/7385439/exception-thrown-in-nsorderedset-generated-accessors/26676124#26676124
    
    [newCity addForecastObject:currentForecast];

    int i = 1;
    
    // Storing directly future forecast for forecast view visualization
    for (NSDictionary *futureForecast in data[@"weather"]) {
        
        Forecast *currentForecast = [Forecast MR_createEntity];
        currentForecast.date = futureForecast[@"date"];
        NSDictionary *endpoint = futureForecast[@"hourly"][0];
        currentForecast.temperature_c = endpoint[@"tempC"];
        currentForecast.temperature_f = endpoint[@"tempF"];
        currentForecast.chance_rain = endpoint[@"chanceofrain"];
        currentForecast.pressure = endpoint[@"pressure"];
        currentForecast.precipitation = endpoint[@"precipitation"];
        currentForecast.wind_speed_km = endpoint[@"windspeedKmph"];
        currentForecast.wind_speed_mi = endpoint[@"windspeedMiles"];
        currentForecast.wind_direction =endpoint[@"winddir16Point"];
        currentForecast.condition = endpoint[@"weatherDesc"][0][@"value"];
        currentForecast.weatherCode = [endpoint[@"weatherCode"] longLongValue];
        [newCity addForecastObject:currentForecast];
        i++;
    }
    
}

-(void)removePreviousWeatherForCity:(City *)city {
    for (Forecast *forecast in city.forecast) {
        [city removeForecastObject:forecast];
    }
    [SETTINGS saveContext];
}

@end
