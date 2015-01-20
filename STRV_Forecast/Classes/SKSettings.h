//
//  SKSettings.h
//  STRV_Forecast
//
//  Created by Simone Kalb on 20/01/15.
//  Copyright (c) 2015 Simone Kalb. All rights reserved.
//

#import <Foundation/Foundation.h>

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

/* Core Data/ Magical Panda support utilities */
- (void)saveContext;


@end
