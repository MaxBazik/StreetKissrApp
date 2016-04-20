//
//  LogInViewController.h
//  Invite
//
//  Created by Yifan Wang on 15/12/18.
//  Copyright © 2015年 Yifan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LogInViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UIButton *logIn;

@property (weak, nonatomic) IBOutlet UIButton *signUp;

- (IBAction)logInPressed:(id)sender;

@end
