//
//  ViewController.h
//  SFK
//
//  Created by LiuHeqian on 3/19/16.
//  Copyright © 2016 LiuHeqian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@class objectsList;

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *singleImageView;

@property (weak, nonatomic) IBOutlet UIButton *previousButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@property (weak, nonatomic) IBOutlet UILabel *singleUsername;

@property(strong, nonatomic) objectsList *objects;

@end

