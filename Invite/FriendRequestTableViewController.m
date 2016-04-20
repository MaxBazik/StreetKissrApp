//
//  FriendRequestTableViewController.m
//  Invite
//
//  Created by Yifan Wang on 16/1/11.
//  Copyright © 2016年 Yifan Wang. All rights reserved.
//

#import "FriendRequestTableViewController.h"
#import "SAMCache.h"
#import "SCLAlertView.h"

@interface FriendRequestTableViewController ()

@end

@implementation FriendRequestTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userManager = [[ParseUserManager alloc]init];
}


-(void)viewWillAppear:(BOOL)animated{
    [self showActivityView];
    
    [self.userManager getRequestUsernameArray:[PFUser currentUser] withAction:@selector(hideActivityView) sender:self];
    
    
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

    return [self.userManager.requestUsers count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSString *key = [[NSString alloc]initWithFormat:@"%@",self.userManager.requestUsers[indexPath.row][@"username"]];
    UIImage *photo = [[SAMCache sharedCache] imageForKey:key];
    
    if (photo) {
        photo = [self imageWithImage:photo scaledToSize:CGSizeMake(50, 50)];
        cell.imageView.image = photo;
    }else{
        PFFile *file = self.userManager.requestUsers[indexPath.row][@"userAvatar"];
        [file getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
            if (error) {
                NSLog(@"error");
            }else{
                UIImage *image = [UIImage imageWithData:data];
                image = [self imageWithImage:image scaledToSize:CGSizeMake(50, 50)];
                cell.imageView.image = image;
                [self.tableView reloadData];
                [[SAMCache sharedCache] setImage:image forKey:key];
            }
        }];
        
    }
    
    
    cell.textLabel.text = self.userManager.requestUsers[indexPath.row][@"username"];
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  80;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
     UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"Agree?" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *agree = [UIAlertAction actionWithTitle:@"Agree" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        PFObject *friendRequest = self.userManager.friendRequest[indexPath.row];
        PFUser *fromUser = [friendRequest objectForKey:@"from"];
        
        //call the cloud function addFriendToFriendRelation which adds the current user to the from users friends:
        //we pass in the object id of the friendRequest as a parameter (you cant pass in objects, so we pass in the id)
        [PFCloud callFunctionInBackground:@"addFriendToFriendsRelation" withParameters:@{@"friendRequest" : friendRequest.objectId} block:^(id object, NSError *error) {
            
            if (!error) {
                //add the fromuser to the currentUsers friends
                PFRelation *friendsRelation = [[PFUser currentUser] relationForKey:@"kissRelation"];
                [friendsRelation addObject:fromUser];
                
                //save the current user
                [[PFUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    
                    if (succeeded) {
                        SCLAlertView *alert =[[SCLAlertView alloc]init];
                        
                        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                        cell.accessoryType = UITableViewCellAccessoryCheckmark;
                        cell.userInteractionEnabled = NO;
                        cell.tintColor = [UIColor orangeColor];
                        
                        [alert showSuccess:self title:@"Congrats" subTitle:@"You have agreed to kiss!" closeButtonTitle:@"OK" duration:0.0];
                        
                    } else {
                        
                    }
                    
                }];
                 
            } else {
                     
            }
                 
        }];
        
        
        
        
    }];
    
    UIAlertAction *refuse = [UIAlertAction actionWithTitle:@"Refuse" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        PFObject *friendRequest = self.userManager.friendRequest[indexPath.row];
        friendRequest[@"status"] = @"refused";
        
        [friendRequest saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (!error) {
                
                UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                cell.userInteractionEnabled = NO;
                cell.textLabel.textColor = [UIColor grayColor];
                
                
                SCLAlertView *alert = [[SCLAlertView alloc]init];
                [alert showNotice:self title:@"Done" subTitle:@"You have refused this request" closeButtonTitle:@"OK" duration:0.0];
            }
        }];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:agree];
    [alert addAction:refuse];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
    
}

-(void) showActivityView {
    if (self.activityView==nil) {
        self.activityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectZero];
        [self.tableView addSubview:self.activityView];
        self.activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        self.activityView.color = [UIColor redColor];
        self.activityView.hidesWhenStopped = YES;
        // additional setup...
        // self.activityView.color = [UIColor redColor];
    }
    // Center
    CGFloat x = UIScreen.mainScreen.applicationFrame.size.width/2;
    CGFloat y = UIScreen.mainScreen.applicationFrame.size.height/2;
    // Offset. If tableView has been scrolled
    CGFloat yOffset = self.tableView.contentOffset.y;
    self.activityView.frame = CGRectMake(x, y + yOffset, 0, 0);
    
    self.activityView.hidden = NO;
    [self.activityView startAnimating];
}


- (void) hideActivityView {
    if ([self.userManager.requestUsers count] == 0) {
        
    }else{
        
        [self.tableView reloadData];
    }
    
    [self.activityView stopAnimating];

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
