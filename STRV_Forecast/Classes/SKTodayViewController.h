//
//  SKTodayViewController.h
//  STRV_Forecast
//
//  Created by Simone Kalb on 19/01/15.
//  Copyright (c) 2015 Simone Kalb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKTodayViewController : UIViewController

@property(strong, nonatomic) IBOutlet UIImageView *conditionIcon;
@property(strong, nonatomic) IBOutlet UILabel *temperatureAndCondition;
@property(strong, nonatomic) IBOutlet UILabel *cityCountry;
@property(strong, nonatomic) IBOutlet UILabel *chanceOfRain;
@property(strong, nonatomic) IBOutlet UILabel *mmRain;
@property(strong, nonatomic) IBOutlet UILabel *pressure;
@property(strong, nonatomic) IBOutlet UILabel *windSpeed;
@property(strong, nonatomic) IBOutlet UILabel *wind16;

@end
