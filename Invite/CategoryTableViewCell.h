//
//  CategoryTableViewCell.h
//  Invite
//
//  Created by Yifan Wang on 15/12/21.
//  Copyright © 2015年 Yifan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *eventName;
@property (weak, nonatomic) IBOutlet UILabel *eventStarter;
@property (weak, nonatomic) IBOutlet UILabel *eventTime;

@end
