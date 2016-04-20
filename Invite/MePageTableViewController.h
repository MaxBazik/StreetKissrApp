//
//  MePageTableViewController.h
//  Invite
//
//  Created by Yifan Wang on 16/1/6.
//  Copyright © 2016年 Yifan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LayoutManager.h"
#import "ParseUserManager.h"

@interface MePageTableViewController : UITableViewController
@property (nonatomic,strong) LayoutManager* layoutManager;
@property (nonatomic,strong) NSArray * titleConfigureArray;
@property (nonatomic,strong) UIImage * avatar;
@property (nonatomic,strong) UIImagePickerController *imagePicker;
@property (nonatomic,strong) ParseUserManager *userManager;
@end
