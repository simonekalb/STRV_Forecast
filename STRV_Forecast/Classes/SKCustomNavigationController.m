//
//  SKCustomNavigationController.m
//  STRV_Forecast
//
//  Created by Simone Kalb on 22/01/15.
//  Copyright (c) 2015 Simone Kalb. All rights reserved.
//

#import "SKCustomNavigationController.h"

@interface SKCustomNavigationController ()

@end

@implementation SKCustomNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [SETTINGS getBoldFontWithSize:21],
      NSFontAttributeName, nil]];
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
