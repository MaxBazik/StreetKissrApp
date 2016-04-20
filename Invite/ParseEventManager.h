//
//  ParseEventManager.h
//  Invite
//
//  Created by Yifan Wang on 15/12/21.
//  Copyright © 2015年 Yifan Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface ParseEventManager : NSObject
@property (nonatomic,strong) NSMutableArray *categoryQueryArray;
@property (nonatomic,strong) NSMutableArray *myPublicQueryArray;
@property (nonatomic,strong) NSMutableArray *myPrivateQueryArray;


typedef void (^action)(void);


+(instancetype)eventManager;

-(void)createNewEventWithCategory:(NSString *)category Name:(NSString *)name  Place:(NSString*)place Description:(NSString*)description Time:(NSString*)time Starter:(NSString*)starter Attenders:(NSString*)attenders isPublic:(BOOL)isPublic;

-(void)getPublicQueryWithCategoryName: (NSString *)categoryName withAction:(SEL)action fromObject:(id)object;

-(void)getMyQueryArray: (NSString *)username withAction:(SEL)action fromObject:(id)object;


-(void)addAttender: (NSString *)attendeeName withEventd:(NSString*)eventId sender:(id)sender;

-(void)deleteAttender: (NSString *)attendeeName withEventd:(NSString*)eventId sender:(id)sender cell:(UITableViewCell*)cell;

@end
