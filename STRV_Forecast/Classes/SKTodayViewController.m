//
//  SKTodayViewController.m
//  STRV_Forecast
//
//  Created by Simone Kalb on 19/01/15.
//  Copyright (c) 2015 Simone Kalb. All rights reserved.
//

#import "SKTodayViewController.h"
#import "SKWWOAPI.h"
#import "Forecast.h"
#import "City.h"

@interface SKTodayViewController ()
@property(nonatomic, strong) Forecast *currentCity;
@end

@implementation SKTodayViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setTitle:NSLocalizedString(@"Today", nil)];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(savedForecastReeceived:) name:CURRENT_FORECAST object:nil];
    
    SKWWOAPI *api = [SKWWOAPI new];
    [api forwardRequest:@"London"];
    
    
}

-(void)savedForecastReeceived:(NSNotification *)notification {
    
    /* I don't want all cities named London, I want only the currentCity */
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"isCurrent == YES"];
    NSArray * allCurrentCities = [Forecast MR_findAllWithPredicate:predicate];
    
    
    Forecast *currentForecast = [allCurrentCities firstObject];
    [self showConditions:currentForecast];
}

-(void)showConditions:(Forecast *)forecast {
    
    _cityCountry.text = forecast.city;
    _temperatureAndCondition.text = [NSString stringWithFormat:@"%@ %@  |  %@", forecast.temperature_c, @"°C", forecast.condition];
    _chanceOfRain.text = [NSString stringWithFormat:@"%@ %%", forecast.chance_rain];
    _mmRain.text = [NSString stringWithFormat:@"%@ mm", forecast.precipitation];
    _wind16.text = forecast.wind_direction;
    _windSpeed.text = [NSString stringWithFormat:@"%@ Km/h",forecast.wind_speed_km];
    _pressure.text = [NSString stringWithFormat:@"%@ hPa", forecast.pressure];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
