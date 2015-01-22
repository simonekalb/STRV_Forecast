//
//  SKSettingsViewController.m
//  STRV_Forecast
//
//  Created by Simone Kalb on 19/01/15.
//  Copyright (c) 2015 Simone Kalb. All rights reserved.
//

#import "SKSettingsViewController.h"

@interface SKSettingsViewController ()

@end

@implementation SKSettingsViewController

- (void)awakeFromNib
{
    [self setTitle:NSLocalizedString(@"Settings", nil)];
    
    //Setting up form
    self.formController.form = [[SKSettingsForm alloc] init];
    
}

-(void)updateLenght {
    SKSettingsForm *form = (SKSettingsForm *)self.formController.form;
    [SETTINGS storeBool:form.lenghtUnits forKey:@"lenghtUnits"];
    
}

-(void)updateDegree {
    SKSettingsForm *form = (SKSettingsForm *)self.formController.form;
    [SETTINGS storeBool:form.degreeUnits forKey:@"degreeUnits"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *title = [(id<UITableViewDataSource>)self.formController tableView:tableView titleForHeaderInSection:section];
    if ([title length])
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, tableView.frame.size.width - 20, 18)];
        label.text = title;
        label.font = [SETTINGS getBoldFontWithSize:14];
        label.textColor = BLUE;
        [label sizeToFit];
        
        UIImageView *underBar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Line_underNavBar"]];
        underBar.frame = CGRectMake(0, 0, 400, 2);
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, label.frame.size.height + 40)];
        view.backgroundColor = [UIColor whiteColor];
        [view addSubview:label];
        [view addSubview:underBar];
        return view;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [self tableView:tableView viewForHeaderInSection:section].frame.size.height;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 
}

@end
