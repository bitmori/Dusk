//
//  DKStyleLabel.m
//  Dusk
//
//  Created by Ke Yang on 1/18/14.
//  Copyright (c) 2014 Pyrus. All rights reserved.
//

#import "DKStyleLabel.h"

@implementation DKStyleLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    if (self.isStrikeThrough) {
        self.textColor = [self.textColor colorWithAlphaComponent:0.6];
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextSetStrokeColorWithColor(ctx, [self.textColor colorWithAlphaComponent:0.6].CGColor);
        CGContextSetLineWidth(ctx, 1);
        CGContextBeginPath(ctx);
        CGFloat halfWayUp = rect.size.height/2 + rect.origin.y;
        CGContextMoveToPoint(ctx, rect.origin.x, halfWayUp );
        CGContextAddLineToPoint(ctx, rect.origin.x + rect.size.width, halfWayUp);
        CGContextStrokePath(ctx);
    }
    [super drawRect:rect];
}

@end
