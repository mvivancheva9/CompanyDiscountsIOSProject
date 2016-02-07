//
//  UserCollectionViewController.h
//  CompanyDiscounts
//
//  Created by Margarita Ivancheva on 2/7/16.
//  Copyright © 2016 Telerik Academy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <CoreData/CoreData.h>

@interface UserCollectionViewController : UICollectionViewController

@property (strong, nonatomic) PFUser *currentUser;

@property (strong, nonatomic) NSManagedObject *user;

@property (strong, nonatomic) NSManagedObject *currentBusiness;

@property (strong, nonatomic) NSString *name;

@property (strong, nonatomic) NSMutableArray *userBusinesses;

@end
