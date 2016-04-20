//
//  LayoutManager.h
//  Invite
//
//  Created by Yifan Wang on 15/12/21.
//  Copyright © 2015年 Yifan Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LayoutManager : NSObject

+(instancetype)layOutManager;

-(NSMutableArray *)getPublicEventConfigureArray;

-(NSArray *)getDetailEventConfigureArray;

-(NSArray *)getMePageConfigureArray;
@end
