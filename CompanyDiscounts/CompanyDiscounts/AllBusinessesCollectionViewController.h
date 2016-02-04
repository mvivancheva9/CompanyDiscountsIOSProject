//
//  AllBusinessesCollectionViewController.h
//  CompanyDiscounts
//
//  Created by Margarita Ivancheva on 2/3/16.
//  Copyright © 2016 Telerik Academy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllBusinessesCollectionViewController : UICollectionViewController

@property (strong, nonatomic) NSArray *businesses;

@property (strong, nonatomic) NSArray *simpleData;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end
