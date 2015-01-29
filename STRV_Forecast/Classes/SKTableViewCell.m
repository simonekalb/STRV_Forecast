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
 
-(void)willTransitionToState:(UITableViewCellStateMask)state{
    NSLog(@"EventTableCell willTransitionToState");
    [super willTransitionToState:state];
    if((state & UITableViewCellStateShowingDeleteConfirmationMask) == UITableViewCellStateShowingDeleteConfirmationMask){
        [self recurseAndReplaceSubViewIfDeleteConfirmationControl:self.subviews];
        [self performSelector:@selector(recurseAndReplaceSubViewIfDeleteConfirmationControl:) withObject:self.subviews afterDelay:0];
    }
}

// This hack works only on iOS 7 and not very well though
-(void)recurseAndReplaceSubViewIfDeleteConfirmationControl:(NSArray*)subviews{
    NSString *delete_button_name = @"Delete";
    for (UIView *subview in subviews)
    {
        
        //the rest handles ios7
        if ([NSStringFromClass([subview class]) isEqualToString:@"UITableViewCellDeleteConfirmationButton"])
        {
            UIButton *deleteButton = (UIButton *)subview;
            [deleteButton setImage:[UIImage imageNamed:delete_button_name] forState:UIControlStateNormal];
            [deleteButton setTitle:@"Delete" forState:UIControlStateNormal];
            [deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [deleteButton setBackgroundColor:[UIColor clearColor]];
            for(UIView* view in subview.subviews){
                if([view isKindOfClass:[UILabel class]]){
                    [view removeFromSuperview];
                }
            }
        }
        if ([NSStringFromClass([subview class]) isEqualToString:@"UITableViewCellDeleteConfirmationView"])
        {
            for(UIView* innerSubView in subview.subviews){
                if(![innerSubView isKindOfClass:[UIButton class]]){
                    [innerSubView removeFromSuperview];
                }
            }
        }
        if([subview.subviews count]>0){
            [self recurseAndReplaceSubViewIfDeleteConfirmationControl:subview.subviews];
        }
        
    }
}




@end
