//
//  BusinessDetailsViewController.m
//  CompanyDiscounts
//
//  Created by Margarita Ivancheva on 2/4/16.
//  Copyright © 2016 Telerik Academy. All rights reserved.
//

#import "BusinessDetailsViewController.h"
#import <Parse/Parse.h>
#import "MapPin.h"
#import "Location.h"

@interface BusinessDetailsViewController ()

@end

@implementation BusinessDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    PFQuery *query = [PFQuery queryWithClassName:@"Business"];
    [query whereKey:@"name" equalTo:self.business.name];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *currentBusiness, NSError *error) {
        if (!currentBusiness) {
            //TODO: Fix this with alert
            NSLog(@"The getFirstObject request failed.");
        } else {
            NSString *businessId = currentBusiness.objectId;
            
            PFQuery *locationsQuery = [PFQuery queryWithClassName:@"Location"];
            [locationsQuery whereKey:@"businessId" equalTo:businessId];
            [locationsQuery findObjectsInBackgroundWithBlock:^(NSArray *businessLocations, NSError *error) {
                if (!error) {
                    // The find succeeded.
                    for (PFObject *object in businessLocations) {
                        self.location = (Location *)object;
                        
                        float latitude = self.location.point.latitude;
                        float longitude = self.location.point.longitude;
                        
                        MapPin *annotation = [[MapPin alloc] init];
                        annotation.coordinate =  CLLocationCoordinate2DMake(latitude, longitude);
                        annotation.title = self.business.name;
                        [self.mapView addAnnotation:annotation];
                    }
                } else {
                    // Log details of the failure
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];
            
        }
    }];

    
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

@end
