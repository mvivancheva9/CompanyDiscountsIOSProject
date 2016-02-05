//
//  UserViewController.m
//  CompanyDiscounts
//
//  Created by Margarita Ivancheva on 2/5/16.
//  Copyright © 2016 Telerik Academy. All rights reserved.
//

#import "UserViewController.h"
#import "User.h"

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
    [PFUser logInWithUsernameInBackground:self.usernameInput.text password:self.passwordInput.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            int n = 5;
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
