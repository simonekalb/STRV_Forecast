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

// World Weather Online API Key
#define API_KEY @"8078210c20e2d625bb0157b622cce"

// Shortcut for calling this class
#define SETTINGS [SKSettings sharedInstance]

// Colors
#define LIGHT_GREY [UIColor colorWithRed:51.0f/255.0f green:51.0f/255.0f blue:51.0f/255.0f alpha:1.0f]
#define BLUE [UIColor colorWithRed:47.0f/255.0f green:145.0f/255.0f blue:255.0f/255.0f alpha:1.0f]

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
-(NSString *)chooseTemperature:(Temperature)temperature forObject:(id)forecast;
-(NSString *)chooseLenght:(Lenght)lenght forObject:(Forecast *)forecast;
-(NSString *)tempToString:(Temperature)temperature;
-(NSString *)lenghtToString:(Lenght)lenght;


/* Fonts and style */
-(UIFont *)getDefaultFontWithSize:(CGFloat)size;
-(UIFont *)getLightFontWithSize:(CGFloat)size;
-(UIFont *)getBoldFontWithSize:(CGFloat)size;
-(UIFont *)getSemiboldFontWithSize:(CGFloat)size;

/* Core Data Insertion support funcions */
-(void)insertNewCity:(NSDictionary *)city;

@end
