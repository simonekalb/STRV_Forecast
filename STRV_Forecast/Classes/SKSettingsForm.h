//
//  SKSettingsForm.h
//  STRV_Forecast
//
//  Created by Simone Kalb on 20/01/15.
//  Copyright (c) 2015 Simone Kalb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FXForms.h>


@interface SKSettingsForm : NSObject<FXForm>

@property (nonatomic, assign) Lenght lenghtUnits;
@property (nonatomic, assign) Temperature degreeUnits;

@end
