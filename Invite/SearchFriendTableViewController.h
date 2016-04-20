//
//  SearchFriendTableViewController.h
//  Invite
//
//  Created by Yifan Wang on 16/1/11.
//  Copyright © 2016年 Yifan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>


@interface SearchFriendTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic,strong) NSArray * foundUsers;
@property (nonatomic,strong) PFUser *selectedUser;

@end
