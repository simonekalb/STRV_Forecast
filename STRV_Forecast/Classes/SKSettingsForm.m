//
//  SKSettingsForm.m
//  STRV_Forecast
//
//  Created by Simone Kalb on 20/01/15.
//  Copyright (c) 2015 Simone Kalb. All rights reserved.
//

#import "SKSettingsForm.h"

@implementation SKSettingsForm

- (NSArray *)fields
{
    return @[
             @{FXFormFieldHeader: @"General",
               FXFormFieldKey: @"lenghtUnits", FXFormFieldOptions: @[@"Meters", @"Inches"]},
             @{FXFormFieldKey: @"degreeUnits", FXFormFieldOptions: @[@"Celsius", @"Fahrenheit"]},
             ];
}

@end
