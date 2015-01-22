//
//  UICustomSearchBar.m
//  STRV_Forecast
//
//  Created by Simone Kalb on 22/01/15.
//  Copyright (c) 2015 Simone Kalb. All rights reserved.
//

#import "UICustomSearchBar.h"

@implementation UICustomSearchBar

- (void)drawRect:(CGRect)rect {
    
    /* Custom search icon */
    [self setImage:[UIImage imageNamed: @"Search"]
            forSearchBarIcon:UISearchBarIconSearch
                       state:UIControlStateNormal];

    /* Custom close button */
    [self setImage:[UIImage imageNamed:@"Close"] forSearchBarIcon:UISearchBarIconClear state:UIControlStateHighlighted];
    [self setImage:[UIImage imageNamed:@"Close"] forSearchBarIcon:UISearchBarIconClear state:UIControlStateNormal];
    
    
    
}


-(void)layoutSubviews{
    [super layoutSubviews];
    [self setShowsCancelButton:NO animated:NO];
}

@end
