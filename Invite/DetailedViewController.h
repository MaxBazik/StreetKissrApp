//
//  DetailedViewController.h
//  SFK
//
//  Created by LiuHeqian on 3/19/16.
//  Copyright © 2016 LiuHeqian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@class objectsList;

@interface DetailedViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *avatarDetailed;
@property (weak, nonatomic) IBOutlet UILabel *usernameText;
@property (weak, nonatomic) IBOutlet UILabel *ratingText;
@property (weak, nonatomic) IBOutlet UILabel *PhoneText;
@property (weak, nonatomic) IBOutlet UILabel *bioText;
@property(strong, nonatomic) NSString* name;
@property(strong, nonatomic) objectsList* objects;
@end
