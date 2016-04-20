//
//  NewEventViewController.m
//  Invite
//
//  Created by Yifan Wang on 15/12/27.
//  Copyright © 2015年 Yifan Wang. All rights reserved.
//

#import "NewEventViewController.h"
#import "ParseEventManager.h"
#import <Parse/Parse.h>
#import "SCLAlertView.h"

@interface NewEventViewController ()<UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate>

@end

@implementation NewEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    
    self.categoryButton.layer.borderColor = [UIColor orangeColor].CGColor;
    self.categoryButton.layer.borderWidth = 0.5;
    
    self.categoryArray = [[NSMutableArray alloc]init];
    [self.categoryArray addObject:@"Game"];
    [self.categoryArray addObject:@"Movie"];
    [self.categoryArray addObject:@"Meal"];
    [self.categoryArray addObject:@"Study"];
    [self.categoryArray addObject:@"Party"];
    [self.categoryArray addObject:@"Custom"];
    
    self.dateField.mask = @"####-##-## ##:##";
    self.dateField.delegate = self;
    self.eventNameField.delegate = self;
    self.placeField.delegate = self;
    self.descriptionField.delegate = self;
    self.dateField.layer.borderWidth = 0.5f;
    self.dateField.layer.borderColor = [UIColor orangeColor].CGColor;
    
    // Do any additional setup after loading the view.
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return  [_dateField shouldChangeCharactersInRange:range replacementString:string];
}

-(void)viewWillAppear:(BOOL)animated{
    self.pickerContainer.alpha = 0;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark - UIPickerView Delegate

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
   
    return 1;
    
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
   
    return [self.categoryArray count];
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return [self.categoryArray objectAtIndex:row];
    
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
   
    self.selectedCategory = [self.categoryArray objectAtIndex:row];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)create:(id)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"Create This Event?" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *create = [UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *name = self.eventNameField.text;
        NSString *place = self.placeField.text;
        NSString *description = self.descriptionField.text;
        NSString *category = self.categoryButton.titleLabel.text;
        NSString *time = self.dateField.text;
        ParseEventManager *manager = [[ParseEventManager alloc]init];
        [manager createNewEventWithCategory:category Name:name Place:place Description:description Time:time Starter:[PFUser currentUser].username Attenders:[PFUser currentUser].username isPublic:self.publicSwitch.on];
        SCLAlertView *alert = [[SCLAlertView alloc]init];
        [alert showSuccess:self title:@"Congrats!"
                  subTitle:@"You have successfully created the event!"
          closeButtonTitle:@"OK" duration:0.0f];
        [self refreshView];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:create];
    [alertController addAction:cancel];
    [self presentViewController:alertController animated:YES completion:nil];

    
}

- (IBAction)changePublic:(id)sender {
    if (self.publicSwitch.on) {
        self.isPublicLabel.textColor = [UIColor redColor];
    }else{
        self.isPublicLabel.textColor = [UIColor lightGrayColor];
    }
}

- (IBAction)okBtn:(id)sender {
    [UIView animateWithDuration:0.3 animations:^{
        self.pickerContainer.alpha = 0;
    }];
    [self.categoryButton setTitle:self.selectedCategory forState:UIControlStateNormal];
    
}

- (IBAction)categoryPressed:(id)sender {
    [UIView animateWithDuration:0.3 animations:^{
        self.pickerContainer.alpha = 1.0;
    }];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark -helper methods
-(void)refreshView{
    self.eventNameField.text = @"";
    self.placeField.text = @"";
    self.descriptionField.text = @"";
    self.categoryButton.titleLabel.text = @"Game";
    self.dateField.text = @"";
    self.publicSwitch.on = NO;
    self.isPublicLabel.textColor = [UIColor lightGrayColor];

}

@end
