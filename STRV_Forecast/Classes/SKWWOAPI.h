//
//  SKWWOAPI.h
//  STRV_Forecast
//
//  Created by Simone Kalb on 19/01/15.
//  Copyright (c) 2015 Simone Kalb. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AFNetworking.h>
#import "WorldWeatherOnline.h"

@interface SKWWOAPI : NSObject <WorldWeatherOnlineDelegate>

-(void)forwardRequest;
@end
