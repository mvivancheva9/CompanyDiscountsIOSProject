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

@interface AllBusinessesCollectionViewController ()

@end

@implementation AllBusinessesCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Business"];
    NSArray* businessesData = [query findObjects];
    
    self.simpleData = [[NSArray alloc]initWithObjects:@"Ala",@"Bala", nil ] ;
    
    self.businesses = businessesData;    
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
    
    Business *currentBusiness = (Business *)[self.businesses objectAtIndex:indexPath.row];
    
    cell.businessNameLabel.text = currentBusiness.name;
    
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
