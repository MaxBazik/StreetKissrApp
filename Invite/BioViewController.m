//
//  BioViewController.m
//  Invite
//
//  Created by Yifan Wang on 16/3/19.
//  Copyright © 2016年 Yifan Wang. All rights reserved.
//

#import "BioViewController.h"
#import <Parse/Parse.h>
#import "SCLAlertView.h"

@interface BioViewController ()

@end

@implementation BioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

-(void)viewWillAppear:(BOOL)animated{
    self.bioTextField.text = [PFUser currentUser][@"bio"];
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

- (IBAction)updatePressed:(id)sender {
    [PFUser currentUser][@"bio"] = self.bioTextField.text;
    [[PFUser currentUser]saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (!error) {
            SCLAlertView *alert = [[SCLAlertView alloc]init];
            [alert showSuccess:self title:@"OK!"
                    subTitle:@"Bio Updated!"
            closeButtonTitle:@"OK" duration:0.0f];
        }
    }];
    
}
@end
