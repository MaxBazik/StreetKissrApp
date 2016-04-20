//
//  DetailedViewController.m
//  SFK
//
//  Created by LiuHeqian on 3/19/16.
//  Copyright © 2016 LiuHeqian. All rights reserved.
//

#import "DetailedViewController.h"
#import "objectsList.h"
@interface DetailedViewController ()

@end

@implementation DetailedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.objects = [[objectsList alloc] initWithName:self.name];
    NSMutableArray *obLis = self.objects.lis;
    self.usernameText.text = obLis[0][@"username"];
    self.bioText.text = obLis[0][@"bio"];
    self.PhoneText.text = obLis[0][@"phone"];
    PFFile *avatarFile = obLis[0][@"userAvatar"];
    NSData *data = [avatarFile getData];
    UIImage *ava = [UIImage imageWithData:data];
    self.avatarDetailed.image = ava;

    
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

@end
