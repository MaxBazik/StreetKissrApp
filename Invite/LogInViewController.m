//
//  LogInViewController.m
//  Invite
//
//  Created by Yifan Wang on 15/12/18.
//  Copyright © 2015年 Yifan Wang. All rights reserved.
//

#import "LogInViewController.h"
#import <Parse/Parse.h>
#import "SCLAlertView.h"

@interface LogInViewController ()<UITextFieldDelegate>

@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    
    self.usernameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    //set up login button
    [[self.logIn layer] setBorderWidth:2.0f];
    [[self.logIn layer] setBorderColor:[UIColor redColor].CGColor];
    
    
    //set up signUp button
    [[self.signUp layer] setBorderWidth:2.0f];
    [[self.signUp layer] setBorderColor:[UIColor redColor].CGColor];
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

- (IBAction)logInPressed:(id)sender {
    NSString *userName = [self.usernameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = [self.passwordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    
    //check & present alert
    if ([userName length] == 0 || [password length] == 0) {
        [alert showError:self title:@"Oops"
                subTitle:@"You have to enter your username and password!"
        closeButtonTitle:@"OK" duration:0.0f];
    }else{
        [PFUser logInWithUsernameInBackground:userName password:password block:^(PFUser * _Nullable user, NSError * _Nullable error) {
            if (!error) {
                [self.navigationController setNavigationBarHidden:NO];
                [self.tabBarController.tabBar setHidden:NO];
                [self.navigationController popViewControllerAnimated:YES];
                
            }else{
                [alert showError:self title:@"Sorry!"
                        subTitle:@"Username or Password not correct!"
                closeButtonTitle:@"Try Again" duration:0.0f];
            }
        }];
    }

    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}




@end
