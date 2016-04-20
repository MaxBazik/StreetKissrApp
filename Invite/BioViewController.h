//
//  BioViewController.h
//  Invite
//
//  Created by Yifan Wang on 16/3/19.
//  Copyright © 2016年 Yifan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BioViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *bioTextField;
- (IBAction)updatePressed:(id)sender;

@end
