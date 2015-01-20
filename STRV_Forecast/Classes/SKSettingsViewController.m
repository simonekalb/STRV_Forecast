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


- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
