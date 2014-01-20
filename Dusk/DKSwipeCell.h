//
//  DKSwipeCell.h
//  Dusk
//
//  Created by Ke Yang on 1/18/14.
//  Copyright (c) 2014 Pyrus. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DKSwipeCellDelegate <NSObject>

- (BOOL)isEditingStatus;
//- (BOOL)isReordering;

@end

@interface DKSwipeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *tokenView;
@property (weak, nonatomic) IBOutlet UIView *foregroundView;
@property (strong, nonatomic) UIPanGestureRecognizer* panGesture;
@property (assign, nonatomic, getter = isReordering) BOOL reordering;

@property (weak, nonatomic) id<DKSwipeCellDelegate> delegate;

- (void)setContent:(NSString*)text;
- (void)setColor:(UIColor*)color;
- (void)setStrikeLine:(BOOL)strike;
- (void)setReorderControlGrip;

@end
