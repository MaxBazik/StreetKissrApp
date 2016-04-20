//
//  objectsList.h
//  SFK
//
//  Created by LiuHeqian on 3/19/16.
//  Copyright © 2016 LiuHeqian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface objectsList : NSObject
@property (strong, nonatomic) NSMutableArray *lis;
@property (strong, nonatomic) NSMutableArray *lisUsed;
@property (strong, nonatomic) NSString *currentUsername;

-(instancetype)init;
-(instancetype)initWithName: (NSString*) name;

@end
