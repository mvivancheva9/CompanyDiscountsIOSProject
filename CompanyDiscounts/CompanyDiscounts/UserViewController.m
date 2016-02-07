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
#import "AppDelegate.h"

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
                                            AppDelegate *appDelegate = [[AppDelegate alloc] init];
                                            NSString *username = user.username;
                                            NSManagedObjectContext *context =[appDelegate managedObjectContext];
                                            NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"User"];
                                            request.predicate = [NSPredicate predicateWithFormat:@"username like %@", username];
                                            NSError *error = nil;
                                            
                                            NSArray *results = [context executeFetchRequest:request error:&error];
                                            
                                            NSLog(@"Count: %li", results.count);

                                            if (results.count == 0) {
                                                NSManagedObject *newUser;
                                                newUser = [NSEntityDescription
                                                           insertNewObjectForEntityForName:@"User"
                                                           inManagedObjectContext:context];
                                                [newUser setValue: username forKey:@"username"];
                                                
                                                if ([context save:&error]) {
                                                    NSLog(@"User saved");
                                                }else{
                                                    NSLog(@"User not saved");
                                                };
                                            }
                                            
                                            
                                            NSString *storyBoardId = @"PreUserScene";
                                            
                                            SWRevealViewController *allBusinessesVC = [self.storyboard instantiateViewControllerWithIdentifier:storyBoardId];
                                            
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
