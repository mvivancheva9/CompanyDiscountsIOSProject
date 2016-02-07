//
//  UserCollectionViewController.m
//  CompanyDiscounts
//
//  Created by Margarita Ivancheva on 2/7/16.
//  Copyright © 2016 Telerik Academy. All rights reserved.
//

#import "UserCollectionViewController.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "AllBusinessesCollectionViewCell.h"
#import "SWRevealViewController.h"
#import "BusinessDetailsViewController.h"
#import "Business.h"

@interface UserCollectionViewController ()

@end

@implementation UserCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

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
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: YES];
    
    NSString *username = self.currentUser.username;
    
    AppDelegate *appDelegate = [[AppDelegate alloc] init];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSError *error = nil;
    
    NSFetchRequest *request2 = [[NSFetchRequest alloc]initWithEntityName:@"User"];
    request2.predicate = [NSPredicate predicateWithFormat:@"username like %@", username];
    
    NSArray *results2 = [context executeFetchRequest:request2 error:&error];
    
    NSSet* users2= [NSSet setWithArray: results2];
    self.user = users2.allObjects.firstObject;
    
    self.userBusinesses = [self.user mutableSetValueForKey:@"userToBusiness"].allObjects;
    
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [self.user mutableSetValueForKey:@"userToBusiness"].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"Cell";
    
    AllBusinessesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    self.currentBusiness = [self.user mutableSetValueForKey:@"userToBusiness"].allObjects[indexPath.row];
    
    self.name = [self.currentBusiness valueForKey:@"name"];
    
    cell.businessNameLabel.text = self.name;
    //cell.userInteractionEnabled = YES;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    Business *business = [Business withName:self.name];
    
    NSString *storyBoardId = @"BusinessDetailsScene";
                                   
    BusinessDetailsViewController *detailsVC = [self.storyboard instantiateViewControllerWithIdentifier:storyBoardId];
                                   
    detailsVC.business = business;
                                   
    [self.navigationController pushViewController:detailsVC animated:YES];
}

@end
