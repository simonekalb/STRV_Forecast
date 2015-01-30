//
//  SKSearchCitiesViewController.m
//  STRV_Forecast
//
//  Created by Simone Kalb on 22/01/15.
//  Copyright (c) 2015 Simone Kalb. All rights reserved.
//

#import "SKSearchCitiesViewController.h"

@interface SKSearchCitiesViewController ()
@property(strong, nonatomic) WorldWeatherOnline *api;
@property(strong, nonatomic) NSArray *result;
@end

@implementation SKSearchCitiesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _api = [[WorldWeatherOnline alloc] initWithApiKey:API_KEY];
    _api.delegate = self;
    
    [[UITextField appearanceWhenContainedIn:[UICustomSearchBar class], nil] setTextColor:BLUE];
    [[UITextField appearanceWhenContainedIn:[UICustomSearchBar class], nil] setFont:[SETTINGS getLightFontWithSize:14.0]];
    
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"Search for a city" attributes:@{ NSForegroundColorAttributeName : BLUE }];
    [[UITextField appearanceWhenContainedIn:[UICustomSearchBar class], nil] setAttributedPlaceholder:str];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Search bar Delegate Methods

-(void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView {
    // Should insert a loading mechanism with HUD
}


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {

    NSString *searchTerms = [searchBar.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    [_api searchLocation:searchTerms];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if(![_result count]) {
        return 0;
    }
    return [_result count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    NSDictionary *currentCity = [_result objectAtIndex:indexPath.row];
    
    UIFont *proximaSemiBold = [UIFont fontWithName:@"ProximaNova-Semibold" size:16.0];
    NSDictionary *proximaDict = [NSDictionary dictionaryWithObject: proximaSemiBold forKey:NSFontAttributeName];
    NSMutableAttributedString *aAttrString = [[NSMutableAttributedString alloc] initWithString:currentCity[@"areaName"][0][@"value"] attributes: proximaDict];
    
    NSString *lastPart = [NSString stringWithFormat:@", %@, %@",
                          currentCity[@"region"][0][@"value"],
                          currentCity[@"country"][0][@"value"]];
    
    UIFont *ProximaLight = [UIFont fontWithName:@"ProximaNova-Light" size:16.0];
    NSDictionary *proximaLigthDict = [NSDictionary dictionaryWithObject:ProximaLight forKey:NSFontAttributeName];
    NSMutableAttributedString *vAttrString = [[NSMutableAttributedString alloc]initWithString:lastPart attributes:proximaLigthDict];
    
    [aAttrString appendAttributedString:vAttrString];
    cell.textLabel.attributedText = aAttrString;
    
    return cell;
     
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *currentCity = [_result objectAtIndex:indexPath.row];
    [SETTINGS insertNewCity:currentCity];
    
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    
    if(selectedCell.accessoryType == UITableViewCellAccessoryCheckmark)
        selectedCell.accessoryType = UITableViewCellAccessoryNone;
    else
        selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
  
    cell.textLabel.textColor = LIGHT_GREY;
    
}

/* Delegate functions */
- (void)requestFailed:(NSString *)message {
    
    NSLog(@"Error: %@", message);
}

- (void)requestSucces:(NSArray *)data {
    
    self.result = data;
    [self.searchDisplayController.searchResultsTableView reloadData];
}

-(IBAction)closeButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}


@end
