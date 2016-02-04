//
//  ViewController.m
//  CompanyDiscounts
//
//  Created by Margarita Ivancheva on 2/1/16.
//  Copyright © 2016 Telerik Academy. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *myLocationLabel;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSString *locationAsString;

@property BOOL locationHasBennDetected;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.locationManager = [[CLLocationManager alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)viewMyLocationButton:(id)sender {
    
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    if(status == kCLAuthorizationStatusAuthorizedAlways){
        NSLog(@"%d",status);
    }
    if(status != kCLAuthorizationStatusDenied && status != kCLAuthorizationStatusRestricted){
        
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager requestAlwaysAuthorization];
        
        self.locationManager.activityType = CLActivityTypeOther;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        self.locationManager.delegate = self;
        self.locationHasBennDetected = NO;
        [self.locationManager startUpdatingLocation];
        
    }
}

- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    CLLocation *newLocation;
    
    if([locations count] == 0){
        return;
    }
    
    newLocation = [locations objectAtIndex:[locations count] - 1];
    
    //check for cashed location
    
    NSTimeInterval locationAge = -[newLocation.timestamp timeIntervalSinceNow];
    
    if(locationAge > 5){
        return;
    }
    
    //horizontal accuracy should not be less than 0
    if(newLocation.horizontalAccuracy < 0){
        return;
    }
    
    NSLog(@"latitude %+.6f, longitude %+.6f\n",
          newLocation.coordinate.latitude,
          newLocation.coordinate.longitude);
    
    
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    
    [geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if([placemarks count] > 0)
        {
            
        CLPlacemark *placemark= [placemarks objectAtIndex:0];
        
        self.locationAsString = [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@",
                                        placemark.subThoroughfare,
                                        placemark.thoroughfare,
                                        placemark.postalCode,
                                        placemark.locality,
                                        placemark.administrativeArea,
                                        placemark.country];
            
            self.myLocationLabel.text = self.locationAsString;
        }
    }];
}

@end
