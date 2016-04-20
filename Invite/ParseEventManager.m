//
//  ParseEventManager.m
//  Invite
//
//  Created by Yifan Wang on 15/12/21.
//  Copyright © 2015年 Yifan Wang. All rights reserved.
//

#import "ParseEventManager.h"
#import "SCLAlertView.h"
@implementation ParseEventManager




+(instancetype)eventManager{
    static ParseEventManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ParseEventManager alloc] init];
    });
    return manager;
}

-(void)createNewEventWithCategory:(NSString *)category Name:(NSString *)name  Place:(NSString *)place Description:(NSString *)description Time:(NSString*)time  Starter:(NSString *)starter Attenders:(NSString *)attenders isPublic:(BOOL)isPublic {
    
    
    
    NSMutableArray*arr = [[NSMutableArray alloc]init];
    [arr addObject:attenders];
    
    PFObject *event = [PFObject objectWithClassName:@"Events"];
    event[@"Category"] = category;
    event[@"Name"] = name;
    event[@"Time"] = time;
    event[@"Place"] = place;
    event[@"Description"] = description;
    event[@"Starter"] = starter;
    event[@"Attenders"] = arr;
    if (isPublic) {
        event[@"isPublic"] = @"Public";
    }else{
        event[@"isPublic"] = @"Private";
    }
    
    [event saveInBackground];
}

-(void)getPublicQueryWithCategoryName:(NSString *)categoryName withAction:(SEL)action fromObject:(id)object{
    
    PFQuery *query = [PFQuery queryWithClassName:@"Events"];
   
    [query whereKey:@"Category" equalTo:categoryName];
    [query whereKey:@"isPublic" equalTo:@"Public"];
    [query orderByDescending:@"Time"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@",error);
        }else{
            self.categoryQueryArray = [[NSMutableArray alloc]initWithArray:objects];
            [object performSelector:action];
        }
    }];
    
    

}

-(void)getMyQueryArray:(NSString *)username withAction:(SEL)action fromObject:(id)object{
    
    PFQuery *query = [PFQuery queryWithClassName:@"Events"];
    
    [query whereKey:@"isPublic" equalTo:@"Public"];
    [query whereKey:@"Attenders" equalTo:username];
    [query orderByDescending:@"Time"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@",error);
        }else{
            self.myPublicQueryArray =[[NSMutableArray alloc]initWithArray:objects];

            [query whereKey:@"isPublic" equalTo:@"Private"];
            [query whereKey:@"Attenders" equalTo:username];
            [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
                if (error) {
                    NSLog(@"%@",error);
                }else{
                    self.myPrivateQueryArray = [[NSMutableArray alloc]initWithArray:objects];
                    [object performSelector:action];
                    
                }
            }];

        }
    }];
    
    
}





-(void)addAttender:(NSString *)attendeeName withEventd:(NSString *)eventId sender:(id)sender{
    
    PFQuery *query = [PFQuery queryWithClassName:@"Events"];
    [query getObjectInBackgroundWithId:eventId block:^(PFObject *event, NSError * _Nullable error) {
        NSMutableArray *arr = event[@"Attenders"];
        SCLAlertView *alert = [[SCLAlertView alloc]init];
        if ([self isInArray:[PFUser currentUser].username array:arr]) {
            [alert showInfo:sender title:@"Notice!"
                   subTitle:@"You Are Already In this Event!"
           closeButtonTitle:@"OK" duration:0.0f];
            
        }else{
            [arr addObject:attendeeName];
            event[@"Attenders"] = arr;
            [event saveInBackground];
            [alert showSuccess:sender title:@"Congrats!"
                      subTitle:@"You Are In!"
              closeButtonTitle:@"OK" duration:0.0f];
            
        }

        
    }];
    
}


-(void)deleteAttender:(NSString *)attendeeName withEventd:(NSString *)eventId sender:(id)sender cell:(UITableViewCell*)cell{
    PFQuery *query = [PFQuery queryWithClassName:@"Events"];
    [query getObjectInBackgroundWithId:eventId block:^(PFObject *event, NSError * _Nullable error) {
        NSMutableArray *arr = event[@"Attenders"];
        SCLAlertView *alert = [[SCLAlertView alloc]init];
        [arr removeObject:attendeeName];
        event[@"Attenders"] = arr;
        [event saveInBackground];
        [alert showSuccess:sender title:@"Done!" subTitle:@"You have successfully quited the event!" closeButtonTitle:@"OK" duration:0.0f];
        cell.accessoryView = nil;
        cell.userInteractionEnabled = NO;
    }];
    
}


#pragma mark Helper Methods:

-(BOOL)isInArray:(NSString *)attendeeName array:(NSArray *)arr{
    for(NSString* str in arr){
        if ([str isEqualToString:attendeeName]) {
            return YES;
        }
    }
    return NO;
}









@end
