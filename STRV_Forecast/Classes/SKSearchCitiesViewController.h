//
//  SKSearchCitiesViewController.h
//  STRV_Forecast
//
//  Created by Simone Kalb on 22/01/15.
//  Copyright (c) 2015 Simone Kalb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UICustomSearchBar.h"
#import "WorldWeatherOnline.h"


@interface SKSearchCitiesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, WorldWeatherOnlineDelegate>

@property(strong, nonatomic) IBOutlet UICustomSearchBar *searchBar;
-(IBAction)closeButtonPressed:(id)sender;

@end
