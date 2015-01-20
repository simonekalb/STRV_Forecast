//
//  SKSettings.m
//  STRV_Forecast
//
//  Created by Simone Kalb on 20/01/15.
//  Copyright (c) 2015 Simone Kalb. All rights reserved.
//

#import "SKSettings.h"
#import "Forecast.h"

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

-(NSString *)chooseTemperature:(Temperature)temperature forObject:(Forecast *)forecast {
    if(temperature == Celsius)
        return forecast.temperature_c;
    return forecast.temperature_f;
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

@end
