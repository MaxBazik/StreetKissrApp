//
//  SignUpViewController.h
//  Invite
//
//  Created by Yifan Wang on 15/12/18.
//  Copyright © 2015年 Yifan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCLAlertView.h"

@interface SignUpViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UITextField *secondPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *phonenumTextField;

@property (weak, nonatomic) IBOutlet UIButton *okButton;
- (IBAction)okPressed:(id)sender;

- (IBAction)backPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *backButton;

@end
