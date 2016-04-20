//
//  MePageTableViewController.m
//  Invite
//
//  Created by Yifan Wang on 16/1/6.
//  Copyright © 2016年 Yifan Wang. All rights reserved.
//

#import "MePageTableViewController.h"
#import <Parse/Parse.h>
#import "MSCellAccessory/MSCellAccessory.h"
#import "SCLAlertView.h"


@interface MePageTableViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation MePageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!self.layoutManager) {
        self.layoutManager = [[LayoutManager alloc]init];
    }

    if (!self.imagePicker) {
        self.imagePicker = [[UIImagePickerController alloc]init];
        self.imagePicker.delegate = self;
    }
    
    self.titleConfigureArray = [self.layoutManager getMePageConfigureArray];
}

-(void)viewWillAppear:(BOOL)animated{
    self.userManager = [[ParseUserManager alloc]init];
    [self.userManager setCurrentUser];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 5;
    }else{
        return 1;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        cell.textLabel.text = self.titleConfigureArray[indexPath.row];
        if (indexPath.row == 0) {
            cell.textLabel.text = [NSString stringWithFormat:@"%@%@", @"Rank: ", [PFUser currentUser][@"rank"]];
            PFFile *file = self.userManager.currentUser[@"userAvatar"];
            [file getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
                self.avatar = [UIImage imageWithData:data];
                self.avatar = [self imageWithImage:self.avatar scaledToSize:CGSizeMake(70.0, 70.0)];
                UIImageView *imageView = [[UIImageView alloc]initWithImage:self.avatar];
                cell.accessoryView = imageView;
            }];
            
            cell.detailTextLabel.text = @"";
        }
        
        else if (indexPath.row == 1) {
            cell.detailTextLabel.text = [PFUser currentUser].username;
            cell.userInteractionEnabled = NO;
        }
        
        else if (indexPath.row == 4) {
            cell.detailTextLabel.text = self.userManager.currentUser[@"phone"];
            cell.userInteractionEnabled = NO;
        }
        
        else{
            cell.accessoryView = [MSCellAccessory accessoryWithType:FLAT_DETAIL_DISCLOSURE colors:@[[UIColor colorWithRed:245/255.0 green:142/255.0 blue:4/255.0 alpha:1.0], [UIColor colorWithWhite:0.7 alpha:1.0]]];
            cell.detailTextLabel.text = @"";
        }
        
    
    }else{
        cell.textLabel.text = @"Logout";
        cell.detailTextLabel.text = @"";
    }
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 100;
    }else{
        return 44;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 1) {
        [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
            [self.tabBarController setSelectedIndex:0];
        }];
        
    }
    else{
        if (indexPath.row == 0) {
             UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"Upload Your Avatar" preferredStyle:UIAlertControllerStyleActionSheet];
            
            UIAlertAction *chooseFromLibrary = [UIAlertAction actionWithTitle:@"Choose From Album" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                //when user tabbed choosefromlibrary
                self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                self.imagePicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:self.imagePicker.sourceType];
                [self presentViewController:self.imagePicker animated:YES completion:nil];
                
            }];
            
            
            UIAlertAction *takePhoto = [UIAlertAction actionWithTitle:@"Take Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                
                self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                self.imagePicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:self.imagePicker.sourceType];
                [self presentViewController:self.imagePicker animated:YES completion:nil];
            }];
            
            
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
            
            
            [alert addAction:cancel];
            [alert addAction:takePhoto];
            [alert addAction:chooseFromLibrary];
            [self presentViewController:alert animated:YES completion:nil];


        }
        else if (indexPath.row == 2) {
            [self performSegueWithIdentifier:@"showBio" sender:self];
        }
        
    }
    
}



#pragma mark resize image
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


#pragma mark - image picker controller delegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.tabBarController setSelectedIndex:0];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    indicator.backgroundColor = [UIColor orangeColor];
    indicator.frame = CGRectMake(160.0, 240.0, 25.0f, 25.0f);
    [picker.view addSubview:indicator];
    [indicator startAnimating];
    UIImage *image =[info objectForKey:UIImagePickerControllerOriginalImage];
    
    
    NSData *avatarData = UIImageJPEGRepresentation(image, 1.0);
    if ([avatarData length] >= 10000000) {
        SCLAlertView *alert = [[SCLAlertView alloc]init];
        [alert showError:self title:@"Whoops" subTitle:@"Image is greater than 10mb please repick" closeButtonTitle:@"OK" duration:0.0f];
        [indicator stopAnimating];
        [indicator setHidden:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }else{
        PFFile *avatar = [PFFile fileWithData:avatarData];
        [self.userManager.currentUser setObject:avatar forKey:@"userAvatar"];
        [self.userManager.currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (succeeded == YES) {
                [indicator stopAnimating];
                [indicator setHidden:YES];
                [self dismissViewControllerAnimated:YES completion:nil];
                [self.tableView reloadData];
            }else{
            
            }
        
        
        }];
    }
    
    
    
}







@end
