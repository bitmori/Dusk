//
//  DKViewController.m
//  Dusk
//
//  Created by Ke Yang on 1/17/14.
//  Copyright (c) 2014 Pyrus. All rights reserved.
//

#import "DKViewController.h"
#import "DKTaskViewController.h"

@interface DKViewController ()
@end

@implementation DKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"pushToList"]) {
        DKTaskViewController* listVC = segue.destinationViewController;
        listVC.colorID = 0;
    }
}

@end
