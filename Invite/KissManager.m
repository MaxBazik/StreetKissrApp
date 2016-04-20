//
//  NSObject+KissManager.m
//  Invite
//
//  Created by Yifan Wang on 16/3/19.
//  Copyright © 2016年 Yifan Wang. All rights reserved.
//

#import "KissManager.h"

@implementation KissManager

+(instancetype)kissManager{
    static KissManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[KissManager alloc] init];
    });
    
    return manager;
}

-(void)getIdsByRank:(UITableViewController *)sender {
    NSMutableArray *names = [[NSMutableArray alloc]init];
    PFQuery *query = [PFUser query];
        
    [query orderByDescending:@"total_score"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
            if (error) {
                NSLog(@"%@",error);
            }else{
                NSMutableArray *tmpQuery = [[NSMutableArray alloc]initWithArray:objects];
                
                NSUInteger size = [tmpQuery count];
                for (NSUInteger j = 0; j<size; j++) {
                    PFUser *user = tmpQuery[j];
                    [names addObject:user];
                }
                self. IdByRankArray = names;
                [sender.tableView reloadData];
            }
        }];
    

    
}



@end
