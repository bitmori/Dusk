//
//  DKDataSingleton.m
//  Dusk
//
//  Created by Ke Yang on 1/18/14.
//  Copyright (c) 2014 Pyrus. All rights reserved.
//

#import "DKDataSingleton.h"

@implementation DKDataSingleton

#pragma mark Singleton Methods
+ (id)sharedData
{
    // this method is implemented by using GCD - grand central dispatch
    static DKDataSingleton* sharedAppData = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedAppData = [[self alloc] init];
    });
    return sharedAppData;
}

- (id)init
{
    if ((self=[super init])) {
        self.colorList =
        @[
          [UIColor colorWithRed:1 green:102/255.0f blue:102/255.0f alpha:1],
          [UIColor colorWithRed:1 green:128/255.0f blue:0 alpha:1],
          [UIColor colorWithRed:1 green:204/255.0f blue:102/255.0f alpha:1],
          [UIColor colorWithRed:128/255.0f green:250/255.0f blue:0 alpha:1],
          [UIColor colorWithRed:102/255.0f green:204/255.0f blue:1 alpha:1],
          [UIColor colorWithRed:1.0f green:111/255.0f blue:207/255.0f alpha:1],
          [UIColor colorWithRed:179/255.0f green:179/255.0f blue:179/255.0f alpha:1],
          [UIColor blackColor]
          ];
    }
    return self;
}

@end
