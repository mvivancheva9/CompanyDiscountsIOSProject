//
//  AddBusinessViewController.m
//  CompanyDiscounts
//
//  Created by Margarita Ivancheva on 2/2/16.
//  Copyright © 2016 Telerik Academy. All rights reserved.
//

#import "AddBusinessViewController.h"
#import "Business.h"



@interface AddBusinessViewController ()
@property (weak, nonatomic) IBOutlet UITextField *businessNameInput;
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
    
    Business *business = [Business withName:name];
    
    [business saveInBackground];
    
}
@end
