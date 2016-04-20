//
//  NSObject+KissManager.h
//  Invite
//
//  Created by Yifan Wang on 16/3/19.
//  Copyright © 2016年 Yifan Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface KissManager: NSObject
@property (nonatomic,strong) NSMutableArray *IdByRankArray;

+(instancetype)kissManager;
-(void)getIdsByRank:(UITableViewController*)sender;


@end
