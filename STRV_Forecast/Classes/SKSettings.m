//
//  SKSettings.m
//  STRV_Forecast
//
//  Created by Simone Kalb on 20/01/15.
//  Copyright (c) 2015 Simone Kalb. All rights reserved.
//

#import "SKSettings.h"
#import "Climacons.h"
#import "Forecast.h"
#import "City.h"
#import "Future.h"

@implementation SKSettings

static SKSettings* _sharedInstance;

+(SKSettings *) sharedInstance {
    if ( !_sharedInstance ) {
        _sharedInstance = [[SKSettings alloc] init];
    }
    return _sharedInstance;
}

#pragma mark - User

-(void)storeValue:(id)value forKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([value isKindOfClass: [UIImage class]]) {
        value = UIImagePNGRepresentation(value);
    }
    [defaults setObject:value forKey:key];
    [defaults synchronize];
}

-(id)retrieveValueForKey: (NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    id value = [defaults objectForKey:key];
    if([value isKindOfClass: [NSData class]]) {
        value = [[UIImage alloc] initWithData: value] ;
    }
    return value;
}

-(void)deleteValueForKey: (NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey: key];
    [defaults synchronize];
}

- (void)storeBool:(BOOL)value forKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:value forKey:key];
    [defaults synchronize];
}

-(BOOL)retrieveBoolForKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL value = [defaults boolForKey:key];
    return value;
}


#pragma mark - iPhone,iPad, iOS and Retina recognizing utilities

-(BOOL)isRetina{
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]
        && [[UIScreen mainScreen] scale] == 2.0) {
        return  YES;
    } else {
        return NO;
    }
}

-(BOOL)isiOS7 {
    return (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1);
}

-(BOOL)isiOS6{
    return [[UIApplication sharedApplication] respondsToSelector:@selector(supportedInterfaceOrientationsForWindow:)];
}

-(BOOL)isiPad {
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
}

-(BOOL)isiPhone {
    return !IS_IPAD;
}

-(BOOL)isiPhone4 {
    return !IS_IPHONE5;
}

-(BOOL)isiPhone5 {
    return [[UIScreen mainScreen] bounds].size.height == 568;
}

#pragma mark - Database support function

- (void)saveContext {
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        if (success) {
            DDLogInfo(@"You successfully saved your context.");
        }
        else if (error) {
            DDLogError(@"Error saving context: %@", error.description);
        }
    }];
}

#pragma mark - Units convertion support functions

-(NSString *)chooseTemperature:(Temperature)temperature forObject:(id)forecast {
    
    if([forecast isMemberOfClass:[Forecast class]]) {
        Forecast *fore = (Forecast *)forecast;
        if(temperature == Celsius) {
            return fore.temperature_c;
        }
        return fore.temperature_f;
    }
    
    Future *future =(Future *)forecast;
    if(temperature == Celsius) {
        return future.temperature_c;
    }
    return future.temperature_f;
                     
}

-(NSString *)chooseLenght:(Lenght)lenght forObject:(Forecast *)forecast {
    if(lenght == Meters)
        return forecast.wind_speed_km;
    return forecast.wind_speed_mi;
}


-(NSString *)tempToString:(Temperature)temperature {
    if(temperature == Celsius)
        return @"°C";
    return @"F";
}

-(NSString *)lenghtToString:(Lenght)lenght {
    if(lenght == Meters)
        return @"Km/h";
    return @"Mi";
}

/* Fonts color and style */
-(UIFont *)getDefaultFontWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"ProximaNova-Regular" size:size];
}

-(UIFont *)getLightFontWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"ProximaNova-Light" size:size];
}

-(UIFont *)getBoldFontWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"ProximaNova-Bold" size:size];
}

-(UIFont *)getSemiboldFontWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"ProximaNova-Semibold" size:size];
}

/* Core Data Insertion support funcions */
-(void)insertNewCity:(NSDictionary *)city {
    
    City *newCity = [City MR_createEntity];
    newCity.name = [city[@"areaName"]firstObject][@"value"];
    newCity.latitude = city[@"latitude"];
    newCity.longitude = city[@"longitude"];
    newCity.weatherURL = [city[@"weatherURL"] firstObject][@"value"];
    [SETTINGS saveContext];
    
}


/* Climacon font support */
-(Climacon)climaconCharacterForWeatherCode:(int)code
{
    if ([@[@395, @392, @374, @371, @368, @350, @338, @335, @332, @329, @326, @323, @230, @179, @227] containsObject:@(code)]) {
        return ClimaconSnow;
    } else if ([@[@365, @362, @320, @317, @182] containsObject:@(code)]) {
        return ClimaconSleet;
    } else if ([@[@389, @386, @356, @314, @311, @308, @305, @302, @299, @176] containsObject:@(code)]) {
        return ClimaconRain;
    } else if ([@[@296, @203, @284, @281, @266, @263, @185] containsObject:@(code)]) {
        return ClimaconDrizzle;
    } else if (code == 359) {
        return ClimaconDownpour;
    } else if (code == 377 || code == 353) {
        return ClimaconShowers;
    } else if (code == 260 || code == 248 || code == 200 || code == 143) {
        return ClimaconFog;
    } else if (code == 122 || code == 119) {
        return ClimaconCloud;
    } else if (code == 116) {
        return ClimaconCloudSun;
    }
    
    //113
    return ClimaconSun;
}

@end
