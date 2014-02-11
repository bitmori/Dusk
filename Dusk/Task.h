//
//  Task.h
//  Dusk
//
//  Created by Ke Yang on 1/21/14.
//  Copyright (c) 2014 Pyrus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Task : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * detail;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSNumber * type;

@end
