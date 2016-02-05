//
//  UserViewController.h
//  CompanyDiscounts
//
//  Created by Margarita Ivancheva on 2/5/16.
//  Copyright © 2016 Telerik Academy. All rights reserved.
//

#import "ViewController.h"

@interface UserViewController : ViewController
@property (weak, nonatomic) IBOutlet UITextField *usernameInput;
@property (weak, nonatomic) IBOutlet UITextField *passwordInput;

-(IBAction)login:(id)sender;

@end
