//
//  ParseUserManager.m
//  Invite
//
//  Created by Yifan Wang on 15/12/18.
//  Copyright © 2015年 Yifan Wang. All rights reserved.
//

#import "ParseUserManager.h"

@implementation ParseUserManager

+(instancetype)userManager{
    static ParseUserManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ParseUserManager alloc] init];
    });
    manager.currentUser = [PFUser currentUser];
   
    return manager;
}


-(void)setCurrentUser{
    
    self.currentUser = [PFUser currentUser];
}


-(void)setFriendRelationArray:(SEL)action sender:(id)sender{
    [self setContactsDictionary];
    PFRelation *friendRelation = [[PFUser currentUser] relationForKey:@"kissRelation"];
    PFQuery *query = [friendRelation query];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error: %@ %@",error,[error userInfo]);
        }else{
            NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:objects];
            
            for (PFUser *user in arr) {
                [self addUsernameToDictionary:user.username];
            }
            [sender performSelector:action];

        }
    }];
    
}

-(void)getPendingRequest:(UITabBarItem*)tabbar setButton:(UIButton*)button{
    
    PFQuery *requestsToUser = [PFQuery queryWithClassName:@"kisses"];
    [requestsToUser whereKey:@"to" equalTo:[PFUser currentUser]];
    [requestsToUser whereKey:@"status" equalTo:@"pending"];
    [requestsToUser findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        self.pendingRequest = [[NSMutableArray alloc] initWithArray:objects];
        
        if ([self.pendingRequest count] == 0) {
            
             tabbar.badgeValue = nil;
            button.backgroundColor = [UIColor lightGrayColor];
            
            
        }else{
             tabbar.badgeValue = [NSString stringWithFormat:@"%lu",(unsigned long)[self.pendingRequest count]];
            button.backgroundColor = [UIColor orangeColor];
            
        }
        
       
       
    }];
    
    
    
}


-(void)getRequestUsernameArray:(PFUser *)currentUser withAction:(SEL)action sender:(id)sender{
    self.friendRequest = [[NSMutableArray alloc]init];
     self.requestUsers = [[NSMutableArray alloc]init];
    PFQuery *query = [PFQuery queryWithClassName:@"kisses"];
    [query whereKey:@"to" equalTo:currentUser];
    [query whereKey:@"status" equalTo:@"pending"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            if ([objects count] == 0) {
                  [sender performSelector:action];
            }else{
    
                for (int i = 0 ; i < [objects count]; i++) {
                    [self.friendRequest addObject:objects[i]];
                    
                    NSString *str =[[objects[i] valueForKey:@"from"] valueForKey:@"objectId"];
                    PFQuery *query = [PFUser query];
                    [query whereKey:@"objectId" equalTo:str];
                    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
                        
                        for(PFUser *user in objects){
                            [self.requestUsers addObject:user];
                        }
                        
                        [sender performSelector:action];
                    }];
                }
                
                
                
            }
        }
        
    }];
     
}


-(void)getInvitationList:(UITabBarItem *)sender setButton:(UIBarButtonItem *)barButton{
    
    self.invitationList = [PFUser currentUser][@"invitations"];
    if ([self.invitationList count] != 0) {
        sender.badgeValue = [NSString stringWithFormat:@"%lu",(unsigned long)[self.invitationList count]];
        barButton.enabled = YES;
    }else{
        sender.badgeValue = nil;
        barButton.enabled = NO;
    }
 
}

-(void)getInvitationList:(SEL)action sender:(id)sender{
    
    self.invitationList = [PFUser currentUser][@"invitations"];
    
    self.invitationArray = [[NSMutableArray alloc]init];
    if ([self.invitationList count] != 0) {
        for(int i = 0; i<[self.invitationList count]; i++){
            PFQuery *query = [PFQuery queryWithClassName:@"Events"];
            [query whereKey:@"objectId" equalTo:self.invitationList[i]];
            [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
                [self.invitationArray addObject:objects[0]];
                if (i == ([self.invitationList count] - 1)) {
                    [sender performSelector:action];
                }
            }];
            
            
        }
        
    }
    
    
}

#pragma mark - helper methods






-(void)setContactsDictionary{
    
    NSMutableArray *nameArray =  [[NSMutableArray alloc]initWithCapacity:27];
    for (int i = 0; i <27; i++) {
        NSMutableArray *name = [[NSMutableArray alloc]init];
        [nameArray addObject:name];
    }
    
    self.contactDictionary = [[NSDictionary alloc] initWithObjects:nameArray forKeys:[UILocalizedIndexedCollation.currentCollation sectionIndexTitles]];
    
}


-(void)addUsernameToDictionary:(NSString *)username{
    
    
    NSString* firstLetter = [username substringToIndex:1];
  
    [firstLetter lowercaseString];
    
    if ([firstLetter  isEqual: @"a"]) {
        [self.contactDictionary[@"A"] addObject:username];
        
    }else if([firstLetter  isEqual: @"b"]){
        [self.contactDictionary[@"B"] addObject:username];
    }else if([firstLetter  isEqual: @"c"]){
        [self.contactDictionary[@"C"] addObject:username];
    }else if([firstLetter  isEqual: @"d"]){
        [self.contactDictionary[@"D"] addObject:username];
    }else if([firstLetter  isEqual: @"e"]){
        [self.contactDictionary[@"E"] addObject:username];
    }else if([firstLetter  isEqual: @"f"]){
        [self.contactDictionary[@"F"] addObject:username];
    }else if([firstLetter  isEqual: @"g"]){
        [self.contactDictionary[@"G"] addObject:username];
    }else if([firstLetter  isEqual: @"h"]){
        [self.contactDictionary[@"H"] addObject:username];
    }else if([firstLetter  isEqual: @"i"]){
        [self.contactDictionary[@"I"] addObject:username];
    }else if([firstLetter  isEqual: @"j"]){
        [self.contactDictionary[@"J"] addObject:username];
    }else if([firstLetter  isEqual: @"k"]){
        [self.contactDictionary[@"K"] addObject:username];
    }else if([firstLetter  isEqual: @"l"]){
        [self.contactDictionary[@"L"] addObject:username];
    }else if([firstLetter  isEqual: @"m"]){
        [self.contactDictionary[@"M"] addObject:username];
    }else if([firstLetter  isEqual: @"n"]){
        [self.contactDictionary[@"N"] addObject:username];
    }else if([firstLetter  isEqual: @"o"]){
        [self.contactDictionary[@"O"] addObject:username];
    }else if([firstLetter  isEqual: @"p"]){
        [self.contactDictionary[@"P"] addObject:username];
    }else if([firstLetter  isEqual: @"q"]){
        [self.contactDictionary[@"Q"] addObject:username];
    }else if([firstLetter  isEqual: @"r"]){
        [self.contactDictionary[@"R"] addObject:username];
    }else if([firstLetter  isEqual: @"s"]){
        [self.contactDictionary[@"S"] addObject:username];
    }else if([firstLetter  isEqual: @"t"]){
        [self.contactDictionary[@"T"] addObject:username];
    }else if([firstLetter  isEqual: @"u"]){
        [self.contactDictionary[@"U"] addObject:username];
    }else if([firstLetter  isEqual: @"v"]){
        [self.contactDictionary[@"V"] addObject:username];
    }else if([firstLetter  isEqual: @"w"]){
        [self.contactDictionary[@"W"] addObject:username];
    }else if([firstLetter  isEqual: @"x"]){
        [self.contactDictionary[@"X"] addObject:username];
    }else if([firstLetter  isEqual: @"y"]){
        [self.contactDictionary[@"Y"] addObject:username];
    }else if([firstLetter  isEqual: @"z"]){
        [self.contactDictionary[@"Z"] addObject:username];
    }else{
        [self.contactDictionary[@"#"] addObject:username];
    }
    

    
}







@end
