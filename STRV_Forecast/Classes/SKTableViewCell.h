//
//  SKTableViewCell.h
//  STRV_Forecast
//
//  Created by Simone Kalb on 21/01/15.
//  Copyright (c) 2015 Simone Kalb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKTableViewCell : UITableViewCell
@property(strong, nonatomic) IBOutlet UIImageView *icon;
@property(strong, nonatomic) IBOutlet UILabel *dayOfWeek;
@property(strong, nonatomic) IBOutlet UILabel *weatherCondition;
@property(strong, nonatomic) IBOutlet UILabel *temperature;
@end
