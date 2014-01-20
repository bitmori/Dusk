//
//  UIView+DKSubViewHunting.m
//  Dusk
//
//  Created by Ke Yang on 1/19/14.
//  Copyright (c) 2014 Pyrus. All rights reserved.
//

#import "UIView+DKSubViewHunting.h"

@implementation UIView (DKSubViewHunting)

- (UIView*) huntedSubviewWithClassName:(NSString*) className
{
	if([[[self class] description] isEqualToString:className])
		return self;
	
	for(UIView* subview in self.subviews)
	{
		UIView* huntedSubview = [subview huntedSubviewWithClassName:className];
		
		if(huntedSubview != nil)
			return huntedSubview;
	}
	
	return nil;
}

/*
- (void) debugSubviews
{
	[self debugSubviews:0];
}

- (void) debugSubviews:(NSUInteger) count
{
	if(count == 0)
		printf("\n\n\n");
	
	for(int i = 0; i <= count; i++)
		printf("--");
	
	printf(" %s\n", [[self class] description].UTF8String);
	
	for(UIView* x in self.subviews)
		[x debugSubviews:(count + 1)];
	
	if(count == 0)
		printf("\n\n\n");
}
*/

@end
