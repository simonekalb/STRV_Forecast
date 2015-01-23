//
//  SKSettingsSubfrom.m
//  STRV_Forecast
//
//  Created by Simone Kalb on 22/01/15.
//  Copyright (c) 2015 Simone Kalb. All rights reserved.
//

#import "SKSettingsSubfrom.h"

@implementation SKSettingsSubfrom

- (NSArray *)fields
{
    return @[
             @{FXFormFieldKey: @"meters",
               FXFormFieldTitle: NSLocalizedString(@"Meters", nil),
               @"textLabel.color": LIGHT_GREY,
               @"textLabel.font": [SETTINGS getDefaultFontWithSize:16.0f]
               },
             @{FXFormFieldKey: @"inches",
               FXFormFieldTitle: NSLocalizedString(@"Inches", nil),
               @"textLabel.color": LIGHT_GREY,
               @"textLabel.font": [SETTINGS getDefaultFontWithSize:16.0f]
            }];
}
@end
