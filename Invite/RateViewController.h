//
//  RateViewController.h
//  Invite
//
//  Created by Yifan Wang on 16/3/19.
//  Copyright © 2016年 Yifan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface RateViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *selectedUserAvatar;
@property (weak, nonatomic) IBOutlet UITextField *score;
@property (weak, nonatomic) IBOutlet UIButton *rateButton;
- (IBAction)rateButtonPressed:(id)sender;
@property (nonatomic,strong) NSString *selectedUser;

@end
