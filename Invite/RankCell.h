//
//  UITableViewCell+RankCell.h
//  Invite
//
//  Created by Yifan Wang on 16/3/19.
//  Copyright © 2016年 Yifan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParseUserManager.h"


@interface RankCell:UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *rank;
@property (weak, nonatomic) IBOutlet UIImageView *useravatar;



@end
