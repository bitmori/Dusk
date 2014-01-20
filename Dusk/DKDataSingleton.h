//
//  DKDataSingleton.h
//  Dusk
//
//  Created by Ke Yang on 1/18/14.
//  Copyright (c) 2014 Pyrus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKDataSingleton : NSObject

@property (nonatomic, strong) NSArray* colorList;

+ (id)sharedData;

@end
