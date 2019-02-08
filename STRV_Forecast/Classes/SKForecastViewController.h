//
//  SKForecastViewController.h
//  STRV_Forecast
//
//  Created by Simone Kalb on 19/01/15.
//  Copyright (c) 2015 Simone Kalb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKForecastViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property(strong, nonatomic) IBOutlet UITableView *tableView;
@end
