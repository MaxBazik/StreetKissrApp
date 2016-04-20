//
//  NewEventViewController.h
//  Invite
//
//  Created by Yifan Wang on 15/12/27.
//  Copyright © 2015年 Yifan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VMaskTextField.h"


@interface NewEventViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *eventNameField;
@property (weak, nonatomic) IBOutlet UITextField *placeField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionField;
@property (weak, nonatomic) IBOutlet UIButton *categoryButton;
@property (weak, nonatomic) IBOutlet UIView *pickerContainer;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (nonatomic,strong) NSMutableArray *categoryArray;
@property (nonatomic,strong) NSString * selectedCategory;
@property (weak, nonatomic) IBOutlet VMaskTextField *dateField;
@property (weak, nonatomic) IBOutlet UILabel *isPublicLabel;
@property (weak, nonatomic) IBOutlet UISwitch *publicSwitch;




- (IBAction)create:(id)sender;

- (IBAction)changePublic:(id)sender;

- (IBAction)okBtn:(id)sender;

- (IBAction)categoryPressed:(id)sender;



@end
