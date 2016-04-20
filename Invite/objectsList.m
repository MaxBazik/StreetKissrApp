//
//  objectsList.m
//  SFK
//
//  Created by LiuHeqian on 3/19/16.
//  Copyright © 2016 LiuHeqian. All rights reserved.
//

#import "objectsList.h"
#import <Parse/Parse.h>
@implementation objectsList
- (instancetype)init
{
    self = [super init];
    if (self) {
        PFQuery *query = [PFUser query];
        [query whereKey:@"username" notEqualTo:@""];
        NSMutableArray *arr = [NSMutableArray arrayWithArray:[query findObjects]];
        for (NSUInteger i = arr.count; i > 1; i--)
            [arr exchangeObjectAtIndex:i - 1 withObjectAtIndex:arc4random_uniform((u_int32_t)i)];
        self.lis = arr;
        self.lisUsed = [[NSMutableArray alloc]init];
        self.currentUsername = @"";
    }
    return self;
}

-(instancetype)initWithName: (NSString*) name
{
    self = [super init];
    if(self) {
        PFQuery *query = [PFUser query];
        [query whereKey:@"username" equalTo:name];
        NSMutableArray *arr = [NSMutableArray arrayWithArray:[query findObjects]];
        self.lis = arr;
        self.lisUsed = [[NSMutableArray alloc]init];
        self.currentUsername = @"";
    }
    return self;
}

@end
