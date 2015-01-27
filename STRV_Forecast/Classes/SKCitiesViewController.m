//
//  SKCitiesViewController.m
//  STRV_Forecast
//
//  Created by Simone Kalb on 21/01/15.
//  Copyright (c) 2015 Simone Kalb. All rights reserved.
//

#import "SKCitiesViewController.h"
#import "SKTableViewCell.h"
#import "City.h"

@interface SKCitiesViewController ()
@property(strong, nonatomic) NSMutableArray *cities;
@end

@implementation SKCitiesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _cities = [NSMutableArray new];
    _cities = [[City MR_findAll] mutableCopy];
    
    NSString* name = [[SKTableViewCell class] description];
    UINib* nib = [UINib nibWithNibName:name bundle:[NSBundle mainBundle]];
    [_tableView registerNib:nib forCellReuseIdentifier:name];

    [self setTitle:NSLocalizedString(@"Location", nil)];
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
    return [_cities count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString* name = [[SKTableViewCell class] description];
    
    SKTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:name];
    
    if (cell == nil) {
        cell = [[SKTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:name];
    }
    City *currentCity = [_cities objectAtIndex:indexPath.row];
    /*
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"YYYY-MM-dd"];
    NSArray *weekDayNames = [df weekdaySymbols];
    NSDate *myDate = [df dateFromString:currentDay.date];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [calendar components:NSWeekdayCalendarUnit fromDate:myDate];
    int weekday =(int)[comps weekday];
    */
    cell.dayOfWeek.text = currentCity.name;
    /*
    Temperature currentTemperatureUnits = [SETTINGS retrieveBoolForKey:@"tempUnits"];
    cell.temperature.text  = [NSString stringWithFormat:@"%@ %@",
                              [SETTINGS chooseTemperature: currentTemperatureUnits
                                                forObject:currentDay],
                              [SETTINGS tempToString:currentTemperatureUnits
                               ]];
    */
    cell.weatherCondition.text  = @"";
    [cell.icon setImage:[UIImage imageNamed:@"WInd_Big"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {

        City *cityToRemove = _cities[indexPath.row];

        // Deleting an Entity with MagicalRecord
        [cityToRemove MR_deleteEntity];
        [SETTINGS saveContext];
        [_cities removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


-(IBAction)doneButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
