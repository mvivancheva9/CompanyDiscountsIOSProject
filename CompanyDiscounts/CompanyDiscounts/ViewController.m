//
//  ViewController.m
//  CompanyDiscounts
//
//  Created by Margarita Ivancheva on 2/1/16.
//  Copyright © 2016 Telerik Academy. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "AddBusinessViewController.h"
#import "UserViewController.h"
#import <Parse/Parse.h>
#import "SWRevealViewController.h"
#import "AllBusinessesCollectionViewController.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Company Discounts";
    // Do any additional setup after loading the view, typically from a nib.
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)goToEmployeeView:(id)sender{
    
    
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        NSString *storyBoardId = @"PreUserScene";
        
        SWRevealViewController *allBusinessesVC = [self.storyboard instantiateViewControllerWithIdentifier:storyBoardId];
        
        //allBusinessesVC.navigationItem.hidesBackButton = YES;
        
        [self.navigationController pushViewController:allBusinessesVC animated:YES];
    } else {
        NSString *storyBoardId = @"UserScene";
        
        UserViewController *userVC = [self.storyboard instantiateViewControllerWithIdentifier:storyBoardId];
        
        [self.navigationController pushViewController:userVC animated:YES];
    }
}

-(IBAction)goToBusinessView:(id)sender{
    
    NSString *storyBoardId = @"AddBusinessScene";
    
    AddBusinessViewController *addBusinessVC = [self.storyboard instantiateViewControllerWithIdentifier:storyBoardId];
    
    [self.navigationController pushViewController:addBusinessVC animated:YES];
}
@end
