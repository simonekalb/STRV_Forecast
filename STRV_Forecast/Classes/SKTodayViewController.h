//
//  SKTodayViewController.h
//  STRV_Forecast
//
//  Created by Simone Kalb on 19/01/15.
//  Copyright (c) 2015 Simone Kalb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface SKTodayViewController : UIViewController<CLLocationManagerDelegate, UIActionSheetDelegate>

@property(strong, nonatomic) IBOutlet UIImageView *conditionIcon;
@property(strong, nonatomic) IBOutlet UILabel *temperatureAndCondition;
@property(strong, nonatomic) IBOutlet UILabel *cityCountry;
@property(strong, nonatomic) IBOutlet UILabel *chanceOfRain;
@property(strong, nonatomic) IBOutlet UILabel *mmRain;
@property(strong, nonatomic) IBOutlet UILabel *pressure;
@property(strong, nonatomic) IBOutlet UILabel *windSpeed;
@property(strong, nonatomic) IBOutlet UILabel *wind16;
@property(strong, nonatomic) IBOutlet UIButton *shareButton;
@property(strong, nonatomic) CLLocationManager *locationManager;

-(IBAction)sharePressed:(id)sender;

@end
