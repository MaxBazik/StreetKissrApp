//
//  ParseUserManager.h
//  Invite
//
//  Created by Yifan Wang on 15/12/18.
//  Copyright © 2015年 Yifan Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface ParseUserManager : NSObject
@property (nonatomic,strong) PFUser *currentUser;
@property (nonatomic,strong) NSDictionary *contactDictionary;
@property (nonatomic,strong) NSArray * pendingRequest;
@property (nonatomic,strong) NSMutableArray *requestUsers;
@property (nonatomic,strong) NSMutableArray *friendRequest;
@property (nonatomic,strong) NSMutableArray *invitationList;
@property (nonatomic,strong) NSMutableArray *invitationArray;


+(instancetype)userManager;

-(void)setCurrentUser;

-(void)setFriendRelationArray:(SEL)action sender:(id)sender;

-(void)getPendingRequest:(UITabBarItem*)sender setButton:(UIButton*)button;

-(void)getRequestUsernameArray:(PFUser*)currentUser withAction:(SEL)action sender:(id)sender;

-(void)getInvitationList:(UITabBarItem*)sender setButton:(UIBarButtonItem *)barButton;

-(void)getInvitationList:(SEL)action sender:(id)sender;


@end
