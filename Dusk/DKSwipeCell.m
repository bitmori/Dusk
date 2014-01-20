//
//  DKSwipeCell.m
//  Dusk
//
//  Created by Ke Yang on 1/18/14.
//  Copyright (c) 2014 Pyrus. All rights reserved.
//

#import "DKSwipeCell.h"
#import "DKStyleLabel.h"
#import "UIView+DKSubViewHunting.h"

@interface DKSwipeCell() <UIGestureRecognizerDelegate>
{
    CGRect tokenBound;
}
@property (assign, nonatomic) CGFloat beginX;
@property (assign, nonatomic) CGFloat tokenX;
@property (assign, nonatomic) BOOL isDraggingWrongDirection;

@property (weak, nonatomic) IBOutlet UILabel *colorLabel;
@property (weak, nonatomic) IBOutlet DKStyleLabel *contentLabel;

- (void)onPanGesture:(UIPanGestureRecognizer*)ges;

@end

@implementation DKSwipeCell

- (void)initializer
{
    self.tokenX = 0;
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPanGesture:)];
    self.panGesture.delegate = self;
    self.isDraggingWrongDirection = NO;
    tokenBound = self.tokenView.bounds;
    [self addGestureRecognizer:self.panGesture];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initializer];
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initializer];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
//    if (selected) {
//        [self.foregroundView setBackgroundColor:[UIColor redColor]];
//    }
}

- (void)setContent:(NSString*)text
{
    [self.contentLabel setText:text];
}

- (void)setColor:(UIColor*)color
{
    [self.colorLabel setBackgroundColor:color];
}

- (void)setStrikeLine:(BOOL)strike
{
    self.contentLabel.isStrikeThrough = strike;
}

- (CGFloat)percentageWithOffset:(CGFloat)offset relativeToWidth:(CGFloat)width {
    CGFloat percentage = offset / width;
    
    if (percentage < -1.0) percentage = -1.0;
    else if (percentage > 1.0) percentage = 1.0;
    
    return percentage;
}

- (void)onPanGesture:(UIPanGestureRecognizer*)ges
{
    if (self.tokenX==0) {
        self.tokenX = self.tokenView.frame.origin.x;
    }
    CGFloat fw = self.foregroundView.frame.size.width;
    CGPoint translation = [ges translationInView:self];
    //CGFloat dir = [self percentageWithOffset:CGRectGetMinX(self.foregroundView.frame) relativeToWidth:CGRectGetWidth(self.bounds)];
    CGPoint vel = [ges velocityInView:self.foregroundView];
    if (vel.x > 0) {
        self.isDraggingWrongDirection = YES;
        [UIView animateWithDuration:.3 animations:^{
            CGRect frame = self.foregroundView.frame;
            frame.origin.x = self.beginX;
            CGRect frame2 = self.tokenView.frame;
            frame2.origin.x = self.tokenX;
            
            self.foregroundView.frame = frame;
            self.tokenView.frame = frame2;
            self.tokenView.alpha = 0;
            
        } completion:^(BOOL finished) {
            if (finished) {
                self.isDraggingWrongDirection = NO;
            }
        }];
        return;
    }
    switch ([ges state]) {
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged:
        {
            CGPoint center = {self.foregroundView.center.x + translation.x, self.foregroundView.center.y};
            self.foregroundView.center = center;
            CGFloat xx = self.foregroundView.frame.origin.x;
            if (xx<=-40) {
                CGRect frame = self.tokenView.frame;
                frame.origin.x = fw + xx;
                self.tokenView.frame = frame;
                if (self.tokenView.alpha != 1.0f) {
                    self.tokenView.alpha = 1.0f;
                }
            } else if (xx<0) {
                self.tokenView.alpha = (xx*xx)/1600.0f;
            }
            [ges setTranslation:CGPointZero inView:self];
        }
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            [UIView animateWithDuration:.3 animations:^{
                CGRect frame = self.foregroundView.frame;
                frame.origin.x = self.beginX;
                CGRect frame2 = self.tokenView.frame;
                frame2.origin.x = self.tokenX;

                self.foregroundView.frame = frame;
                self.tokenView.frame = frame2;
                self.tokenView.alpha = 0;
            }];
        }
            break;
        default:
            break;
    }
}

- (void)setReorderControlGrip
{
    UIView* reorderControl = [self huntedSubviewWithClassName:@"UITableViewCellReorderControl"];
    //NSLog(@"%d", [reorderControl respondsToSelector:@selector(initWithTableViewCell:)]);
//    CGRect newFrame = {{280, 0}, {20, 40}};
//    [reorderControl setFrame:newFrame];
//    NSLog(@"%@", NSStringFromCGRect(reorderControl.bounds));
    for(UIImageView* cellGrip in reorderControl.subviews)
    {
        if([cellGrip isKindOfClass:[UIImageView class]])
            [cellGrip setImage:nil];
    }
//    [reorderControl setBackgroundColor:[UIColor redColor]];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ([gestureRecognizer class] == [UIPanGestureRecognizer class]) {
        
        UIPanGestureRecognizer *g = (UIPanGestureRecognizer *)gestureRecognizer;
        CGPoint point = [g velocityInView:self];
        
        if (fabsf(point.x) > fabsf(point.y) ) {
            if (self.isReordering || self.isDraggingWrongDirection || point.x > 0) {
                return NO;
            }
            
            return YES;
        }
        
    }
    
    return NO;
}

@end
