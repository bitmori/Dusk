//
//  DKTaskViewController.m
//  Dusk
//
//  Created by Ke Yang on 1/17/14.
//  Copyright (c) 2014 Pyrus. All rights reserved.
//

#import "DKTaskViewController.h"
#import "DKSwipeCell.h"
#import "DKDataSingleton.h"
#import "UIView+DKSubViewHunting.h"
#import "Task.h"

@interface DKTaskViewController () <DKSwipeCellDelegate>


@property (strong, nonatomic) UIColor* color;
- (IBAction)add:(id)sender;

@end

@implementation DKTaskViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)fetchData
{
    self.data = [NSMutableArray arrayWithArray:[Task findAll]];
    //[Task findAllSortedBy:@"date" ascending:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self fetchData];
    //self.data = [NSMutableArray arrayWithArray:@[@"Chris", @"Leon", @"Ada", @"Sherry"]];
    
    DKDataSingleton* sharedData = [DKDataSingleton sharedData];
    self.color = sharedData.colorList[self.colorID];

    [self setEditing:YES];
    
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    [self.tableView setAllowsSelectionDuringEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setEditing:(BOOL)editing
{
    [super setEditing:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    DKSwipeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell==nil) {
        cell = [[DKSwipeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    Task* task = self.data[indexPath.row];
    [cell setContent:task.title];
    [cell setColor:self.color];
    [cell setStrikeLine:YES];
    [cell setReorderControlGrip];
    cell.delegate = self;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}
/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView willBeginReorderingRowAtIndexPath:(NSIndexPath *)indexPath
{
    DKSwipeCell* cell = (DKSwipeCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    [cell setReordering:YES];
}
- (void)tableView:(UITableView *)tableView didEndReorderingRowAtIndexPath:(NSIndexPath *)indexPath
{
    DKSwipeCell* cell = (DKSwipeCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    [cell setReordering:NO];
}
- (void)tableView:(UITableView *)tableView didCancelReorderingRowAtIndexPath:(NSIndexPath *)indexPath
{
    DKSwipeCell* cell = (DKSwipeCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    [cell setReordering:NO];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[(DKSwipeCell*)cell setReorderControlGrip];
}

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

- (IBAction)add:(id)sender {
    
}

- (BOOL)isEditingStatus
{
    return self.isEditing;
}

@end
