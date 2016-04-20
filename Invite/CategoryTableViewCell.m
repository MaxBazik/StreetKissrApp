//
//  CategoryTableViewCell.m
//  Invite
//
//  Created by Yifan Wang on 15/12/21.
//  Copyright © 2015年 Yifan Wang. All rights reserved.
//

#import "CategoryTableViewCell.h"

@implementation CategoryTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)prepareForReuse{
    self.eventName.text = @"Event Name";
    self.eventStarter.text = @"Created by";
    self.eventTime.text = @"Time";
    
    self.layer.borderWidth = 0;
    self.layer.borderColor = [UIColor clearColor].CGColor;
    self.eventTime.textColor = [UIColor blackColor];
    self.userInteractionEnabled = YES;
}

@end
