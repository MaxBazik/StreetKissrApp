//
//  FriendRequestTableViewController.h
//  Invite
//
//  Created by Yifan Wang on 16/1/11.
//  Copyright © 2016年 Yifan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "ParseUserManager.h"

@interface FriendRequestTableViewController : UITableViewController
@property (nonatomic,assign) NSArray* friendRequests;
@property (nonatomic,strong) UIActivityIndicatorView *activityView;
@property (nonatomic,strong) ParseUserManager *userManager;
@end
