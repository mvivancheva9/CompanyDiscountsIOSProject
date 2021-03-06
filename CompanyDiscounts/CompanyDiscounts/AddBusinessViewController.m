//
//  AddBusinessViewController.m
//  CompanyDiscounts
//
//  Created by Margarita Ivancheva on 2/2/16.
//  Copyright © 2016 Telerik Academy. All rights reserved.
//

#import "AddBusinessViewController.h"
#import "Business.h"
#import "AddLocationViewController.h"



@interface AddBusinessViewController () <UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *businessNameInput;
@property (weak, nonatomic) IBOutlet UITextField *businessDiscountInput;
- (IBAction)addBusinessBtnTapped:(id)sender;

@end

@implementation AddBusinessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
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

- (IBAction)addBusinessBtnTapped:(id)sender {
    
    NSString *name = self.businessNameInput.text;
    
    NSString *discount = self.businessDiscountInput.text;
    
    Business *business = [Business withName:name andWithDiscount:discount];
    
    [business saveInBackground];
    
    NSString *storyBoardId = @"addLocationScene";
    
    AddLocationViewController *addLocationVC =
    [self.storyboard instantiateViewControllerWithIdentifier:storyBoardId];
    addLocationVC.business = business;
    
    [self.navigationController pushViewController:addLocationVC animated:YES];
    
}
@end
