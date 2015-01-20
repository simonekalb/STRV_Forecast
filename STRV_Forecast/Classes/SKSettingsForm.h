//
//  SKSettingsForm.h
//  STRV_Forecast
//
//  Created by Simone Kalb on 20/01/15.
//  Copyright (c) 2015 Simone Kalb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FXForms.h>

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


@interface SKSettingsForm : NSObject<FXForm>

@property (nonatomic, assign) Lenght lenghtUnits;
@property (nonatomic, assign) Temperature degreeUnits;

@end
