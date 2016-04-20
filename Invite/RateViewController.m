//
//  RateViewController.m
//  Invite
//
//  Created by Yifan Wang on 16/3/19.
//  Copyright © 2016年 Yifan Wang. All rights reserved.
//

#import "RateViewController.h"
#import "SCLAlertView.h"

@interface RateViewController ()

@end

@implementation RateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.score.layer.borderWidth = 2.0f;
    self.score.layer.borderColor = [[UIColor orangeColor] CGColor];
    self.rateButton.layer.borderWidth = 2.0f;
    self.rateButton.layer.borderColor = [[UIColor redColor] CGColor];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    PFQuery *query = [PFUser query];
    [query whereKey:@"username" equalTo:self.selectedUser];
    NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:[query findObjects]];
    PFUser *user = arr[0];
    
    PFFile *file = user[@"userAvatar"];
    [file getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        NSData *imagedata = data;
        UIImage *image = [UIImage imageWithData:imagedata];
        image = [self imageWithImage:image scaledToSize:CGSizeMake(100, 100)];
        self.selectedUserAvatar.image = image;
    }];
    
    if (![[PFUser currentUser][@"kissedUser"] containsObject:self.selectedUser]) {
        [self.rateButton setEnabled:YES];
        self.rateButton.layer.borderColor = [[UIColor redColor] CGColor];
    }
    if([[PFUser currentUser][@"kissedUser"] containsObject:self.selectedUser]){
        [self.rateButton setEnabled:NO];
        self.rateButton.layer.borderColor = [[UIColor grayColor] CGColor];
    }
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)rateButtonPressed:(id)sender {
    NSString *score = self.score.text;
    NSNumber  *aNum = [NSNumber numberWithInteger: [score integerValue]];
    NSNumber* initial = [PFUser currentUser][@"total_score"];
    initial =@([aNum intValue]+[initial intValue]);
    NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:[PFUser currentUser][@"kisseduser"]];
    [arr addObject:self.selectedUser];
    [PFUser currentUser][@"kissedUser"] = arr;
    [PFUser currentUser][@"total_score"] = initial;
    [[PFUser currentUser] saveInBackground];
    
    [self.rateButton setEnabled:NO];
    self.rateButton.layer.borderColor = [[UIColor grayColor] CGColor];
    [PFCloud callFunctionInBackground:@"addScoreToUser" withParameters:@{@"username":self.selectedUser,@"value":initial} block:^(id  _Nullable object, NSError * _Nullable error) {
        SCLAlertView *alert = [[SCLAlertView alloc]init];
        [alert showNotice:self title:@"Done" subTitle:@"You have rated!" closeButtonTitle:@"OK" duration:0.0];
    }];
    
    
    
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
