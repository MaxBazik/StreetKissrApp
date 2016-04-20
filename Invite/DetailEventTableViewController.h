//
//  DetailEventTableViewController.h
//  Invite
//
//  Created by Yifan Wang on 15/12/23.
//  Copyright © 2015年 Yifan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LayoutManager.h"

@interface DetailEventTableViewController : UITableViewController
@property (nonatomic,strong) LayoutManager *layoutManager;
@property (nonatomic,strong) NSArray *configureArray;
@property (nonatomic,strong) NSDictionary *detailInformationArray;
@property (nonatomic,strong) NSString *chosenEventId;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *inButton;
- (IBAction)inButtonTabbed:(id)sender;

@end

