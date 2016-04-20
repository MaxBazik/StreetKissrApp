//
//  LayoutManager.m
//  Invite
//
//  Created by Yifan Wang on 15/12/21.
//  Copyright © 2015年 Yifan Wang. All rights reserved.
//

#import "LayoutManager.h"
#import <UIKit/UIKit.h>

@implementation LayoutManager

+(instancetype)layOutManager{
    static LayoutManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LayoutManager alloc] init];
    });
    return manager;
};

-(NSMutableArray *)getPublicEventConfigureArray{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSDictionary *gameCate = @{@"label":@"Game",@"image":@"Cards-80-2"};
    [array addObject:gameCate];
    
    NSDictionary *movieCate = @{@"label":@"Movie",@"image":@"Movie-80-2"};
    [array addObject:movieCate];
    
    NSDictionary *mealCate = @{@"label":@"Meal",@"image":@"Meal-80-3"};
    [array addObject:mealCate];
    
    NSDictionary *studyCate = @{@"label":@"Study",@"image":@"Reading-80"};
    [array addObject:studyCate];
    
    NSDictionary *partyCate = @{@"label":@"Party",@"image":@"Dancing-80-2"};
    [array addObject:partyCate];
    
    NSDictionary *customCate = @{@"label":@"Custom",@"image":@"Theatre Mask-80"};
    [array addObject:customCate];
    
    return array;
}

-(NSArray *)getDetailEventConfigureArray{
    
    
    
    return [NSArray arrayWithObjects:@"Name",@"Starter",@"Place",@"Time",@"Description", nil];
    
    
}

-(NSArray *)getMePageConfigureArray{
    
    return [NSArray arrayWithObjects:@"User Avatar:",@"Username:",@"Bio:",@"location:", @"phone number",nil];
}





@end
