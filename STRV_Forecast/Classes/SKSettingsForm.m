//
//  SKSettingsForm.m
//  STRV_Forecast
//
//  Created by Simone Kalb on 20/01/15.
//  Copyright (c) 2015 Simone Kalb. All rights reserved.
//

#import "SKSettingsForm.h"
#import "SKSettingsSubfrom.h"

@implementation SKSettingsForm

- (NSArray *)fields
{
    return @[
             @{FXFormFieldHeader: @"GENERAL",
               FXFormFieldKey: @"lenghtUnits",
               FXFormFieldTitle: NSLocalizedString(@"Units of lenght", nil),
               FXFormFieldOptions: @[@"Meters", @"Inches"],
               FXFormFieldAction: @"updateLenght", @"textLabel.color": LIGHT_GREY,
               @"textLabel.font": [SETTINGS getDefaultFontWithSize:16.0f],
               @"detailTextLabel.font": [SETTINGS getDefaultFontWithSize:16.0f],
               @"detailTextLabel.color": BLUE
               },
             @{FXFormFieldKey: @"degreeUnits", FXFormFieldOptions: @[@"Celsius", @"Fahrenheit"],
               FXFormFieldTitle: NSLocalizedString(@"Units of temperature", nil),
               FXFormFieldAction: @"updateDegree", @"textLabel.color": LIGHT_GREY,
               @"textLabel.font": [SETTINGS getDefaultFontWithSize:16.0f],
               @"detailTextLabel.font": [SETTINGS getDefaultFontWithSize:16.0f],
               @"detailTextLabel.color": BLUE
               }];
}

@end
