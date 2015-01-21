//
//  SKForecastViewController.m
//  STRV_Forecast
//
//  Created by Simone Kalb on 19/01/15.
//  Copyright (c) 2015 Simone Kalb. All rights reserved.
//

#import "SKForecastViewController.h"
#import "SKCustomForecastCellTableViewCell.h"
#import "Future.h"

@interface SKForecastViewController ()
@property(strong, nonatomic) NSMutableArray *daysForecast;
@end

@implementation SKForecastViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _daysForecast = [NSMutableArray new];
    _daysForecast = [[Future MR_findAll] mutableCopy];
    [self setTitle:NSLocalizedString(@"Forecast", nil)];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_daysForecast count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    SKCustomForecastCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[SKCustomForecastCellTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
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
