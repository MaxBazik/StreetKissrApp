//
//  SearchFriendTableViewController.m
//  Invite
//
//  Created by Yifan Wang on 16/1/11.
//  Copyright © 2016年 Yifan Wang. All rights reserved.
//

#import "SearchFriendTableViewController.h"
#import "SAMCache.h"
#import "SCLAlertView.h"

@interface SearchFriendTableViewController ()<UISearchBarDelegate>

@end

@implementation SearchFriendTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchBar.delegate = self;
    self.searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma  mark - Search Bar Delegate Methods

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    //dismiss keyboard and reload table
    [self.searchBar resignFirstResponder];
    [self.tableView reloadData];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    //Enable the cancel button when the user touches the search field
    self.searchBar.showsCancelButton = TRUE;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    
    //disable the cancel button when the user ends editing
    self.searchBar.showsCancelButton = FALSE;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    //dismiss keyboard
    [self.searchBar resignFirstResponder];
    
    //reset the foundUser property
    self.foundUsers = nil;
    
    
    //Strip the whitespace off the end of the search text
    NSString *searchText = [self.searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    //Check to make sure the field isnt empty and Query parse for username in the text field
    if (![searchText isEqualToString:@""]) {
        
        PFQuery *query = [PFUser query];
        [query whereKey:@"username" containsString:searchText];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                
                //check to make sure the query actually found a user
                if (objects.count > 0) {
                    
                    //set your foundUser property to the user that was found by the query (we use last object since its an array)
                    self.foundUsers = objects;
                    
                    
                    //The query was succesful but returned no results. A user was not found, display error message
                } else {
                    
                    SCLAlertView *alert = [[SCLAlertView alloc]init];
                    [alert showInfo:self title:@"Notice" subTitle:@"No Users Found!" closeButtonTitle:@"OK" duration:0.0];
                    
                }
                //reload the tableView after the user searches
                [self.tableView reloadData];
                
            } else {
                
                //error occurred with query
                
            }
            
        }];
        
    }
    
    
}







#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.foundUsers count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    
    NSString *key = [[NSString alloc]initWithFormat:@"%@",self.foundUsers[indexPath.row][@"username"]];
    UIImage *photo = [[SAMCache sharedCache] imageForKey:key];
    
    if (photo) {
        photo = [self imageWithImage:photo scaledToSize:CGSizeMake(30, 30)];
        cell.imageView.image = photo;
    }else{
        PFFile *file = self.foundUsers[indexPath.row][@"userAvatar"];
        [file getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
            if (error) {
                NSLog(@"error");
            }else{
                UIImage *image = [UIImage imageWithData:data];
               image = [self imageWithImage:image scaledToSize:CGSizeMake(30, 30)];
                cell.imageView.image = image;
                [self.tableView reloadData];
                [[SAMCache sharedCache] setImage:image forKey:key];
            }
        }];

    }
    
    
    cell.textLabel.text = self.foundUsers[indexPath.row][@"username"];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  80;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"Wanna kiss?" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *add  = [UIAlertAction actionWithTitle:@"Kiss!" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        self.selectedUser = self.foundUsers[indexPath.row];
        
        PFObject *friendRequest = [PFObject objectWithClassName:@"kisses"];
        
        friendRequest[@"from"] = [PFUser currentUser];
        
        friendRequest[@"to"] = self.selectedUser;
        
        friendRequest[@"status"] = @"pending";
        
        [friendRequest saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            
            if (succeeded) {

                SCLAlertView *alert = [[SCLAlertView alloc]init];
                [alert showSuccess:self title:@"Done!" subTitle:@"Kiss Request is sent and waiting for reply!" closeButtonTitle:@"OK" duration:0.0];
     
                
            } else {
                
                // error occurred
            }
        }];
        
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:add];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
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
