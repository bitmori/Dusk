//
//  UIView+DKSubViewHunting.h
//  Dusk
//
//  Created by Ke Yang on 1/19/14.
//  Copyright (c) 2014 Pyrus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (DKSubViewHunting)

- (UIView*) huntedSubviewWithClassName:(NSString*) className;
//- (void) debugSubviews;

@end
