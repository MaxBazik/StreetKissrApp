//
//  RankPageTableViewController.m
//  Invite
//
//  Created by Yifan Wang on 16/3/19.
//  Copyright © 2016年 Yifan Wang. All rights reserved.
//

#import "RankPageTableViewController.h"
#import "RankCell.h"

@interface RankPageTableViewController ()


@end

@implementation RankPageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"RankCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    ParseUserManager *userManager = [[ParseUserManager alloc] init];
    self.userManager = userManager;
    self.kissManaer = [[KissManager alloc]init];
    
    self.tabBarController.tabBar.tintColor = [UIColor redColor];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.userManager setCurrentUser];
    
    if (self.userManager.currentUser) {
        [self.tabBarController.tabBar setHidden:NO];
        [self.kissManaer getIdsByRank:self];
    }
    else{
        [self.tabBarController.tabBar setHidden:YES];
        [self performSegueWithIdentifier:@"showLogin" sender:self];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0)
    {
        return [self.kissManaer.IdByRankArray count];
    }
    else {
        return 1;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RankCell *cell = (RankCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil)
    {
        cell = [[RankCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    cell.username.text = self.kissManaer.IdByRankArray[indexPath.row][@"username"];
    cell.rank.text =[NSString stringWithFormat:@"%@%@",@"rank: ",self.kissManaer.IdByRankArray[indexPath.row][@"total_score"]];
    
    PFFile *file = self.kissManaer.IdByRankArray[indexPath.row][@"userAvatar"];
    [file getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        NSData *imagedata = data;
        UIImage *image = [UIImage imageWithData:imagedata];
        image = [self imageWithImage:image scaledToSize:CGSizeMake(90, 90)];
        cell.useravatar.image = image;
        [self.tableView reloadData];
    }];
    
    return cell;
}

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}



@end
