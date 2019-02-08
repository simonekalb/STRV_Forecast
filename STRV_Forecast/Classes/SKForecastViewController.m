//
//  SKForecastViewController.m
//  STRV_Forecast
//
//  Created by Simone Kalb on 19/01/15.
//  Copyright (c) 2015 Simone Kalb. All rights reserved.
//

#import "SKForecastViewController.h"
#import "SKTableViewCell.h"
#import "Future.h"

@interface SKForecastViewController ()
@property(strong, nonatomic) NSMutableArray *daysForecast;
@end

@implementation SKForecastViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _daysForecast = [NSMutableArray new];
    _daysForecast = [[Future MR_findAll] mutableCopy];
    
    NSString* name = [[SKTableViewCell class] description];
    UINib* nib = [UINib nibWithNibName:name bundle:[NSBundle mainBundle]];
    [_tableView registerNib:nib forCellReuseIdentifier:name];
    
    [self setTitle:NSLocalizedString(@"Forecast", nil)];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_daysForecast count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString* name = [[SKTableViewCell class] description];
    
    SKTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:name];
    
    if (cell == nil) {
        cell = [[SKTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:name];
    }
    Future *currentDay = [_daysForecast objectAtIndex:indexPath.row];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"YYYY-MM-dd"];
    NSArray *weekDayNames = [df weekdaySymbols];
    NSDate *myDate = [df dateFromString:currentDay.date];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [calendar components:NSWeekdayCalendarUnit fromDate:myDate];
    int weekday =(int)[comps weekday];
    
    cell.dayOfWeek.text = [weekDayNames objectAtIndex:weekday-1];
    
    Temperature currentTemperatureUnits = [SETTINGS retrieveBoolForKey:@"tempUnits"];
    cell.temperature.text  = [NSString stringWithFormat:@"%@ %@",
                            [SETTINGS chooseTemperature: currentTemperatureUnits
                                              forObject:currentDay],
                            [SETTINGS tempToString:currentTemperatureUnits
                            ]];
    
    cell.weatherCondition.text  = currentDay.condition;
    [cell.icon setImage:[UIImage imageNamed:@"WInd_Big"]];
    return cell;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
