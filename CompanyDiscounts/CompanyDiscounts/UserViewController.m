//
//  UserViewController.m
//  CompanyDiscounts
//
//  Created by Margarita Ivancheva on 2/5/16.
//  Copyright © 2016 Telerik Academy. All rights reserved.
//

#import "UserViewController.h"
#import "User.h"
#import "AllBusinessesCollectionViewController.h"
#import "SWRevealViewController.h"

@interface UserViewController ()

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)login:(id)sender{
    
    User *user = [User withUsername:self.usernameInput.text andWithPassword:self.passwordInput.text];
    
    [PFUser logInWithUsernameInBackground:user.username password:user.password
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            NSString *storyBoardId = @"PreUserScene";
                                            
                                            SWRevealViewController *allBusinessesVC = [self.storyboard instantiateViewControllerWithIdentifier:storyBoardId];
                                            
                                            //allBusinessesVC.navigationItem.hidesBackButton = YES;
                                            
                                            [self.navigationController pushViewController:allBusinessesVC animated:YES];
                                        } else {
                                            UIAlertController * alert=   [UIAlertController
                                                                          alertControllerWithTitle:@"Verification Failed"
                                                                          message:[NSString stringWithFormat: @"Check your credencials"]
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
