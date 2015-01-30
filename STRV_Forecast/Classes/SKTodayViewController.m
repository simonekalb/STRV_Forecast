//
//  SKTodayViewController.m
//  STRV_Forecast
//
//  Created by Simone Kalb on 19/01/15.
//  Copyright (c) 2015 Simone Kalb. All rights reserved.
//

#import "SKTodayViewController.h"
#import "SKWWOAPI.h"
#import "Climacons.h"
#import "Forecast.h"
#import "City.h"

@interface SKTodayViewController ()
@property(nonatomic, strong) Forecast *currentCity;
@property(nonatomic) Lenght lenghtUnits;
@property(nonatomic) Temperature degreeUnits;
@property(nonatomic, strong) CLGeocoder *geocoder;
@property(nonatomic, strong) NSString *locationName;
@property(nonatomic) float longitude;
@property(nonatomic) float latitude;
@end

@implementation SKTodayViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setTitle:NSLocalizedString(@"Today", nil)];
    [self resetCondition];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(savedForecastReceived:) name:CURRENT_FORECAST object:nil];
    [self updateLocation];
}


#pragma mark - Update Location delegate methods

/** Inizialize the locationManager */
-(void)updateLocation
{
    // locationManager update as location
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
    
    // Setting the filter for didUpdateToLocation to 3km
    self.locationManager.distanceFilter = 3000;
    
    // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager requestAlwaysAuthorization];
    }
    
    [self.locationManager startUpdatingLocation];
    CLLocation *location = [self.locationManager location];
    
    if(location)
    {
        self.longitude = location.coordinate.longitude;
        self.latitude = location.coordinate.latitude;

    }
    else
        DDLogWarn(@"Location NULL");
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    CLLocation *lastLocation =  [locations lastObject];
    self.longitude = lastLocation.coordinate.longitude;
    self.latitude = lastLocation.coordinate.latitude;
    [self gettingLocationName];
    
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
        case kCLAuthorizationStatusRestricted:
        case kCLAuthorizationStatusDenied:
        {
            // do some error handling
        }
            break;
        default:{
            [self.locationManager startUpdatingLocation];
        }
            break;
    }
}

-(void)gettingLocationName {
    
    if(self.longitude != 0.0f)
    {
        if (!self.geocoder)
            self.geocoder = [[CLGeocoder alloc] init];
        
        CLLocation *currentLocation = [[CLLocation alloc] initWithLatitude:self.latitude longitude:self.longitude];
        
        [self.geocoder reverseGeocodeLocation:currentLocation
                            completionHandler:^(NSArray* placemarks, NSError *error)
         {
             CLPlacemark *placemark = [placemarks objectAtIndex:0];
             NSString *locatedAt = [placemark locality];
             
             if(![self.locationName isEqualToString:locatedAt])
             {
                 self.locationName = locatedAt;
                 SKWWOAPI *api = [SKWWOAPI new];
                 [api forwardRequest:self.locationName];
             }
             
         }];
    }
}

#pragma mark - View specific delegate methods


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
}

-(void)savedForecastReceived:(NSNotification *)notification {
    
    /* I don't want all cities named "London", I want only the currentCity */
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"city CONTAINS[cd] %@", self.locationName];
    NSArray * allCurrentCities = [Forecast MR_findAllWithPredicate:predicate];
    
    if([allCurrentCities count] > 0) {
        Forecast *currentForecast = [allCurrentCities firstObject];
        [self showConditions:currentForecast];
    } else
        [self resetCondition];
}

/* Reset the current weather condition table */
-(void)resetCondition {
    _weatherCondition.font = [UIFont fontWithName:CLIMACONS_FONT size:115];
    _weatherCondition.text =  [NSString stringWithFormat:@"%c", ClimaconSun];
    
    _cityCountry.text = @"No city selected";
    _temperatureAndCondition.text = [NSString stringWithFormat:@"-- %@  | --",
                                     [SETTINGS tempToString:_degreeUnits]];
    _chanceOfRain.text = @"-- %";
    _mmRain.text = @"-- mm";
    _wind16.text = @"--";
    _windSpeed.text = [NSString stringWithFormat:@"-- %@",[SETTINGS lenghtToString:_lenghtUnits]];
    _pressure.text = @"-- hPa";
}

-(void)showConditions:(Forecast *)forecast {
    
    _weatherCondition.font = [UIFont fontWithName:CLIMACONS_FONT size:115];
    _weatherCondition.text =  [NSString stringWithFormat:@"%c", [SETTINGS climaconCharacterForWeatherCode:(int)forecast.weatherCode]];
    
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



/* Sharing actions */

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

@end
