//
//  SKTableViewCell.m
//  STRV_Forecast
//
//  Created by Simone Kalb on 21/01/15.
//  Copyright (c) 2015 Simone Kalb. All rights reserved.
//

#import "SKTableViewCell.h"

@implementation SKTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)willTransitionToState:(UITableViewCellStateMask)state{
    [super willTransitionToState:state];
    if ((state & UITableViewCellStateShowingDeleteConfirmationMask) == UITableViewCellStateShowingDeleteConfirmationMask) {
        for (UIView *subview in self.subviews) {
            if ([NSStringFromClass([subview class]) isEqualToString:@"UITableViewCellDeleteConfirmationControl"]) {
                UIImageView *deleteBtn = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 64, 33)];
                [deleteBtn setImage:[UIImage imageNamed:@"Delete.png"]];
                [[subview.subviews objectAtIndex:0] addSubview:deleteBtn];
                
            }
        }
    }
}


- (void)setFrame:(CGRect)frame {
    /* Setting the frame for the iPhone 4 and iPhone 5 */
    if(IS_IPHONE5 || IS_IPHONE4) {
        if (self.superview){
            float cellWidth = 320.0;
            frame.origin.x = (self.superview.frame.size.width - cellWidth) / 2;
            frame.size.width = cellWidth;
        }
    }
    [super setFrame:frame];
}
 
@end
