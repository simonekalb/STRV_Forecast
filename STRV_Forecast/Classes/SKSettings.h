//
//  SKSettings.h
//  STRV_Forecast
//
//  Created by Simone Kalb on 20/01/15.
//  Copyright (c) 2015 Simone Kalb. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Forecast;

typedef NS_ENUM(NSInteger, Lenght)
{
    Meters = 0,
    Inches
    
};

typedef NS_ENUM(NSInteger, Temperature)
{
    Celsius = 0,
    Fahrenheit
};



// Shortcut for calling this class
#define SETTINGS [SKSettings sharedInstance]

// iOS Version
#define IS_IOS7_AND_UP ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
#define IS_IOS7 [[SKSettings sharedInstance] isiOs7]
#define IS_IOS6 [[SKSettings sharedInstance] isiOs6]

// Device type
#define IS_IPAD [[SKSettings sharedInstance] isiPad]
#define IS_IPHONE [[SKSettings sharedInstance] isiPhone]
#define IS_IPHONE4 [[SKSettings sharedInstance] isiPhone4]
#define IS_IPHONE5 [[SKSettings sharedInstance] isiPhone5]
#define IS_RETINA [[SKSettings sharedInstance] isRetina]

// Magical Record
#define SAVE_CONTEXT [SKSettings saveContext]


// Notification Names
#define CURRENT_FORECAST @"savedForecastNotification" 

@interface SKSettings : NSObject

+(SKSettings *) sharedInstance;

/* Practical functions to store/retrieve values from/to NSUserDefault */
-(void)storeValue:(id)value forKey:(NSString *)key;
-(id)retrieveValueForKey: (NSString *)key;
-(void)deleteValueForKey: (NSString *)key;
-(void)storeBool:(BOOL)value forKey:(NSString *)key;
-(BOOL)retrieveBoolForKey:(NSString *)key;

/* iPhone/iPad recognition routines */
-(BOOL)isRetina;
-(BOOL)isiOS7;
-(BOOL)isiOS6;
-(BOOL)isiPad;
-(BOOL)isiPhone;
-(BOOL)isiPhone4;
-(BOOL)isiPhone5;


/* Core Data/Magical Panda support utilities */
- (void)saveContext;


/* Units convertion utilities */
-(NSString *)chooseTemperature:(Temperature)temperature forObject:(Forecast *)forecast;
-(NSString *)chooseLenght:(Lenght)lenght forObject:(Forecast *)forecast;
-(NSString *)tempToString:(Temperature)temperature;
-(NSString *)lenghtToString:(Lenght)lenght;
@end
