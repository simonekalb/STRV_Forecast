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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 87.0f;
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
    
    cell.dayOfWeek.text = [currentCity.name componentsSeparatedByString:@","][0];
    cell.weatherCondition.text  = @"Sunny";
    [cell.icon setImage:[UIImage imageNamed:@"WInd_Big"]];
    cell.temperature.text  = @"12°";
    
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
}

// Just for iOS 8
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"Delete"  handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        [_cities removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    deleteAction.backgroundColor = ORANGE;
    
    return @[deleteAction];
}




-(IBAction)doneButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
