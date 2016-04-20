//
//  RankPageTableViewController.h
//  Invite
//
//  Created by Yifan Wang on 16/3/19.
//  Copyright © 2016年 Yifan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParseUserManager.h"
#import "KissManager.h"



@interface RankPageTableViewController : UITableViewController
@property(nonatomic,strong) ParseUserManager *userManager;
@property(nonatomic,strong) KissManager *kissManaer;


@end
