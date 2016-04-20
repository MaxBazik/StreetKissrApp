//
//  SignUpViewController.m
//  Invite
//
//  Created by Yifan Wang on 15/12/18.
//  Copyright © 2015年 Yifan Wang. All rights reserved.
//

#import "SignUpViewController.h"
#import <Parse/Parse.h>

@interface SignUpViewController ()<UITextFieldDelegate>

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.usernameTextField.delegate = self;
    self.emailTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.secondPasswordTextField.delegate = self;
    
    [[self.okButton layer] setBorderWidth:2.0f];
    [[self.okButton layer] setBorderColor:[UIColor redColor].CGColor];
    
    [[self.backButton layer] setBorderWidth:2.0f];
    [[self.backButton layer] setBorderColor:[UIColor redColor].CGColor];


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

- (IBAction)okPressed:(id)sender {
    
    NSString *userName = [self.usernameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = [self.passwordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *secondPassword = [self.secondPasswordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *email = [self.emailTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *phonenum = [self.phonenumTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    
    if ([userName length] == 0 || [password length]==0 || [secondPassword length]==0 || [email length]==0 || [phonenum length]==0) {
        [alert showError:self title:@"Sorry!"
                subTitle:@"All Fields Are Reuquired!"
        closeButtonTitle:@"OK" duration:0.0f];
    }else if (![password isEqualToString:secondPassword]){
        [alert showError:self title:@"Try Again"
                subTitle:@"Passwords Don'y Match!"
        closeButtonTitle:@"OK" duration:0.0f];
    }else{
        
        PFUser *newUser = [PFUser user];
        newUser.username = userName;
        newUser.password = password;
        newUser.email = email;
        newUser[@"phone"] = phonenum;
        newUser[@"rank"] = @"100";
        
        
        
        NSData *avatarData = UIImagePNGRepresentation([UIImage imageNamed:@"User-50"]);
        PFFile *file = [PFFile fileWithData:avatarData];
        newUser[@"userAvatar"] = file;
        
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        newUser[@"invitations"] = arr;
        
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (error) {
                NSString *errorMessage = [error localizedDescription];
                [alert showError:self title:@"Try Again" subTitle:errorMessage closeButtonTitle:@"OK" duration:0.0f];
                
            }else{
                self.navigationController.navigationBarHidden = NO;
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }];
    }
    
}

- (IBAction)backPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
