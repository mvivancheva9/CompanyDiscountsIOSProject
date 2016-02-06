//
//  SidebarTableViewController.m
//  CompanyDiscounts
//
//  Created by Margarita Ivancheva on 2/6/16.
//  Copyright © 2016 Telerik Academy. All rights reserved.
//

#import "SidebarTableViewController.h"
#import "AllBusinessesCollectionViewController.h"
#import <Parse/Parse.h>
#import "ViewController.h"
#import "SWRevealViewController.h"

@interface SidebarTableViewController ()

@end

@implementation SidebarTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.options = [[NSArray alloc] initWithObjects:@"", @"Your Discounts", @"All Discounts", @"Logout", nil];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.options.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: identifier forIndexPath:indexPath];
    
    cell.textLabel.text = [self.options objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 1){
        NSString *storyBoardId = @"PreUserScene";
        
        SWRevealViewController *allBusinessesVC = [self.storyboard instantiateViewControllerWithIdentifier:storyBoardId];
        
        [self.navigationController pushViewController:allBusinessesVC animated:YES];
    }else if(indexPath.row == 2){
        NSString *storyBoardId = @"AllBusinessesScene";
        
        AllBusinessesCollectionViewController *businessesVC = [self.storyboard instantiateViewControllerWithIdentifier:storyBoardId];
        
        [self.navigationController pushViewController:businessesVC animated:YES];
    }else if (indexPath.row == 3){
        [PFUser logOut];
        PFUser *currentUser = [PFUser currentUser];
        
        NSString *storyBoardId = @"MainViewScene";
        
        ViewController *mainViewVC = [self.storyboard instantiateViewControllerWithIdentifier:storyBoardId];
        
        [self.navigationController pushViewController:mainViewVC animated:YES];
        
        
    }
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
