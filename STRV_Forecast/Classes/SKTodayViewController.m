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
@property(nonatomic) Lenght lenghtUnits;
@property(nonatomic) Temperature degreeUnits;
@end

@implementation SKTodayViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setTitle:NSLocalizedString(@"Today", nil)];
    

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(savedForecastReeceived:) name:CURRENT_FORECAST object:nil];
 
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // Retrieving units from settings
    _lenghtUnits = [SETTINGS retrieveBoolForKey:@"lenghtUnits"];
    _degreeUnits = [SETTINGS retrieveBoolForKey:@"degreeUnits"];
    
    if (!_lenghtUnits) {
        _lenghtUnits = Meters;
    }
    
    if (!_degreeUnits) {
        _degreeUnits = Celsius;
    }
    
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
    
    /* Choosing the right units for temperature according to settings */
    _temperatureAndCondition.text = [NSString stringWithFormat:@"%@ %@  |  %@",
                                     [SETTINGS chooseTemperature:_degreeUnits forObject:forecast],
                                     [SETTINGS tempToString:_degreeUnits],
                                     forecast.condition];
    
    _chanceOfRain.text = [NSString stringWithFormat:@"%@ %%", forecast.chance_rain];
    
    _mmRain.text = [NSString stringWithFormat:@"%@ mm", forecast.precipitation];
    _wind16.text = forecast.wind_direction;
    
    /* Choosing the right units for lenght according to settings */
    _windSpeed.text = [NSString stringWithFormat:@"%@ %@",
                       [SETTINGS chooseLenght:_lenghtUnits forObject:forecast],
                       [SETTINGS lenghtToString:_lenghtUnits]];
    
    _pressure.text = [NSString stringWithFormat:@"%@ hPa", forecast.pressure];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

-(IBAction)sharePressed:(id)sender {
    [self shareText:[NSString stringWithFormat:@"Today Forecast for %@", _cityCountry] andUrl:[NSURL URLWithString:@"http://www.worldweatheronline.com"]];
}

- (void)shareText:(NSString *)text andUrl:(NSURL *)url
{
    NSMutableArray *sharingItems = [NSMutableArray new];
    
    if (text) {
        [sharingItems addObject:text];
    }
    if (url) {
        [sharingItems addObject:url];
    }
    
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:sharingItems applicationActivities:nil];
    [self presentViewController:activityController animated:YES completion:nil];
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
