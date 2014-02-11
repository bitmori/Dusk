//
//  DKDetailViewController.h
//  Dusk
//
//  Created by Ke Yang on 1/19/14.
//  Copyright (c) 2014 Pyrus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"

@interface DKDetailViewController : UIViewController

@property (strong, nonatomic) Task* task;
@property (assign, nonatomic, getter = isEditing) BOOL editing;

@end
