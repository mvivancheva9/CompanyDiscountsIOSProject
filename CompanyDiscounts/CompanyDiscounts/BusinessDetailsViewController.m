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
//@import MapKit;

@interface BusinessDetailsViewController () <MKMapViewDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation BusinessDetailsViewController

@synthesize mapView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc] init];
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
                        [mapView addAnnotation:annotation];
                    }
                } else {
                    //TODO: Add Alert
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];
            
        }
    }];

    
}

-(IBAction)GetLocation:(id)sender{
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager requestAlwaysAuthorization];

    mapView.showsUserLocation = YES;

}
- (IBAction)setMap:(id)sender {
    
    switch (((UISegmentedControl *)sender).selectedSegmentIndex) {
        case 0:
            mapView.mapType = MKMapTypeStandard;
            break;
        case 1:
            mapView.mapType = MKMapTypeSatellite;
            break;
            
        default:
            break;
    }
}

- (IBAction)getDirections:(id)sender{
    
    
    NSString *urlString = @"http://maps.apple.com/maps?daddr=";
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    MKPointAnnotation *annotation=(MKPointAnnotation*)view.annotation;
    self.tappedCoord = annotation.coordinate;
    
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