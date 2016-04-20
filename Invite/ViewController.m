//
//  ViewController.m
//  SFK
//
//  Created by LiuHeqian on 3/19/16.
//  Copyright © 2016 LiuHeqian. All rights reserved.
//

#import "ViewController.h"
#import "objectsList.h"
#import "DetailedViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTintColor:[UIColor orangeColor]];
   [self.previousButton setEnabled:NO];
    self.previousButton.tintColor = [UIColor grayColor];
    self.objects = [[objectsList alloc] init];
    NSMutableArray *obLis = self.objects.lis;
    PFUser *selectedOne = self.objects.lis[obLis.count-1];
    [obLis removeObjectAtIndex:obLis.count-1];
    [self.objects.lisUsed addObject:selectedOne];
    self.objects.lis = obLis;
    
    NSString *usernameSelected = selectedOne[@"username"];
    PFFile *avatarFile = selectedOne[@"userAvatar"];
    NSData *data = [avatarFile getData];
    UIImage *ava = [UIImage imageWithData:data];
    
    self.singleImageView.image = ava;
    self.singleUsername.text = usernameSelected;
    self.objects.currentUsername = self.singleUsername.text;

}

- (IBAction)goPrevious {
    [self.nextButton setEnabled:YES];
    self.nextButton.tintColor =[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
    NSMutableArray *obLisUsed = self.objects.lisUsed;
    PFUser *selectedOne = obLisUsed[obLisUsed.count-1];

    [self.objects.lis addObject:selectedOne];
    [obLisUsed removeObjectAtIndex:obLisUsed.count-1];
    
    if (obLisUsed.count == 1) {
        [self.previousButton setEnabled:NO];
        self.previousButton.tintColor = [UIColor grayColor];
    }
    self.objects.lisUsed = obLisUsed;
    
    NSString *usernameSelected = self.objects.lisUsed[self.objects.lisUsed.count-1][@"username"];
    PFFile *avatarFile = self.objects.lisUsed[self.objects.lisUsed.count-1][@"userAvatar"];
    NSData *data = [avatarFile getData];
    UIImage *ava = [UIImage imageWithData:data];
    
    self.singleImageView.image = ava;
    self.singleUsername.text = usernameSelected;
    self.objects.currentUsername = self.singleUsername.text;

}

- (IBAction)goNext {

    self.previousButton.tintColor =[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
    [self.previousButton setEnabled:YES];
    NSMutableArray *obLis = self.objects.lis;
    PFUser *selectedOne = obLis[obLis.count-1];

    [self.objects.lisUsed addObject:selectedOne];
    [obLis removeObjectAtIndex:obLis.count-1];
    if (obLis.count == 1) {
        [self.nextButton setEnabled:NO];
        self.nextButton.tintColor = [UIColor grayColor];
    }
    self.objects.lis = obLis;
    
    NSString *usernameSelected = self.objects.lis[self.objects.lis.count-1][@"username"];
    PFFile *avatarFile = self.objects.lis[self.objects.lis.count-1][@"userAvatar"];
    NSData *data = [avatarFile getData];
    UIImage *ava = [UIImage imageWithData:data];
    
    self.singleImageView.image = ava;
    self.singleUsername.text = usernameSelected;
    self.objects.currentUsername = self.singleUsername.text;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqual:@"showUserDetail"]) {
        NSString *name = self.singleUsername.text;
        DetailedViewController *detailedViewController = (DetailedViewController *)[segue destinationViewController];
        detailedViewController.name = name;
    }
}

- (IBAction)showUserDetail:(id)sender {
    [self performSegueWithIdentifier:@"showUserDetail" sender:sender];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
