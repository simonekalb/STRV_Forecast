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

-(void)viewDidLoad {
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

}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
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
    cell.temperature.text  = [NSString stringWithFormat:@"%@%@",
                            [SETTINGS chooseTemperature: currentTemperatureUnits
                                              forObject:currentDay],
                            [SETTINGS tempToString:currentTemperatureUnits
                            ]];
    
    cell.weatherCondition.text  = currentDay.condition;

    [cell.climaCon setText:[NSString stringWithFormat:@"%c",
                            [SETTINGS climaconCharacterForWeatherCode:(int)currentDay.weatherCode]]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 75, 0, 0)];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 75, 0, 0)];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
}


@end
