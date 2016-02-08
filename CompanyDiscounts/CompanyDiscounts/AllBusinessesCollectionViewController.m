//
//  AllBusinessesCollectionViewController.m
//  CompanyDiscounts
//
//  Created by Margarita Ivancheva on 2/3/16.
//  Copyright © 2016 Telerik Academy. All rights reserved.
//

#import "AllBusinessesCollectionViewController.h"
#import <Parse/Parse.h>
#import "AllBusinessesCollectionViewCell.h"
#import "Business.h"
#import "BusinessDetailsViewController.h"
#import "SWRevealViewController.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

@interface AllBusinessesCollectionViewController () <UICollectionViewDelegate>

@end

@implementation AllBusinessesCollectionViewController

-(void)viewDidAppear:(BOOL)animated{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView setDelegate:self];
    self.currentUser = [PFUser currentUser];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background3.png"]];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    PFQuery *query = [PFQuery queryWithClassName:@"Business"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *businessData, NSError *error) {
        if (!error) {
            self.businesses = businessData;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
            });
        } else {
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:@"Failed"
                                          message:[NSString stringWithFormat: @"Failed Loading Businesses"]
                                          preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
            
            [alert addAction:ok];
            
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.businesses.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"Cell";
    
    AllBusinessesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    Business *currentBusiness = [self.businesses objectAtIndex:indexPath.row];
    
    NSString* name = currentBusiness.name;
    
    NSString *text = ([NSString stringWithFormat:@"%@ %@", name, currentBusiness.discount]);
    
    cell.businessNameLabel.text = text;
    //cell.userInteractionEnabled = YES;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    Business *business = [self.businesses objectAtIndex:indexPath.row];
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Options"
                                  message:[NSString stringWithFormat: @"Choose what to do with this business discounts"]
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* goToMaps = [UIAlertAction
                         actionWithTitle:@"Go To Maps"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             NSString *storyBoardId = @"BusinessDetailsScene";
                             
                             BusinessDetailsViewController *detailsVC = [self.storyboard instantiateViewControllerWithIdentifier:storyBoardId];
                             
                             detailsVC.business = business;
                             
                             [self.navigationController pushViewController:detailsVC animated:YES];
                             
                         }];
    UIAlertAction* addToMyList = [UIAlertAction
                               actionWithTitle:@"Add To My List"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                                   AppDelegate *appDelegate = [[AppDelegate alloc] init];
                                   
                                   NSString *businessName = business.name;
                                   NSString *username = self.currentUser.username;
                                   NSManagedObjectContext *context =
                                   [appDelegate managedObjectContext];
                                   
                        
                                   NSManagedObject *newBusiness;
                                   newBusiness = [NSEntityDescription
                                              insertNewObjectForEntityForName:@"Business"
                                              inManagedObjectContext:context];
                                   [newBusiness setValue: businessName forKey:@"name"];
                                   
                                   NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"User"];
                                   request.predicate = [NSPredicate predicateWithFormat:@"username like %@", username];
                                   NSError *error = nil;
                                   
                                   NSArray *results = [context executeFetchRequest:request error:&error];
                                   
                                   NSLog(@"Count: %li", results.count);
                                   
                                   if (results.count == 1) {
                                       NSSet* users= [NSSet setWithArray: results];
                                       [newBusiness setValue: users forKey:@"businessToUser"];
                                       if ([context save:&error]) {
                                           NSLog(@"Business saved");
                                           
                                       }else{
                                           NSLog(@"Business not saved");
                                       };
                                   }
                                   NSString *storyBoardId = @"PreUserScene";
                                   
                                   SWRevealViewController *allBusinessesVC = [self.storyboard instantiateViewControllerWithIdentifier:storyBoardId];
                                   
                                   allBusinessesVC.navigationItem.hidesBackButton = YES;
                                   
                                   [self.navigationController pushViewController:allBusinessesVC animated:YES];
                               }];
    
    
    [alert addAction:goToMaps];
    [alert addAction:addToMyList];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
}
@end
