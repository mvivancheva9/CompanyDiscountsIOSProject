//
//  AddLocationViewController.m
//  CompanyDiscounts
//
//  Created by Margarita Ivancheva on 2/3/16.
//  Copyright © 2016 Telerik Academy. All rights reserved.
//

#import "AddLocationViewController.h"
#import "Location.h"
#import "MapPin.h"
#import "CompanyDiscounts-Swift.h"
#import "AppDelegate.h"

@interface AddLocationViewController ()

@end

@implementation AddLocationViewController

@synthesize mapView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Business Location";
    
    [self addGestureRecogniserToMapView];
}

- (void)addGestureRecogniserToMapView{
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(addPinToMap:)];
    lpgr.minimumPressDuration = 0.5; //
    [self.mapView addGestureRecognizer:lpgr];
    
}

- (void)addPinToMap:(UIGestureRecognizer *)gestureRecognizer
{
    
    if (gestureRecognizer.state != UIGestureRecognizerStateBegan)
        return;
    
    CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];
    CLLocationCoordinate2D touchMapCoordinate =
    [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
    
    MapPin *annotation = [[MapPin alloc] init];
    annotation.coordinate = touchMapCoordinate;
    annotation.title = self.business.name;
    annotation.subTitle = self.business.discount;
    [self.mapView addAnnotation:annotation];
    
    float latitude = annotation.coordinate.latitude;
    float longitude = annotation.coordinate.longitude;
    
    PFQuery *query = [PFQuery queryWithClassName:@"Business"];
    [query whereKey:@"name" equalTo:self.business.name];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *currentBusiness, NSError *error) {
        if (!currentBusiness) {
            //TODO: Fix this with alert
            NSLog(@"The getFirstObject request failed.");
        } else {
            self.businessId = currentBusiness.objectId;
            
            PFGeoPoint *point = [PFGeoPoint geoPointWithLatitude:latitude longitude:longitude];
            
            Location *location = [Location withGeoPoint:point andWithBusinessId: self.businessId];
            
            [location saveInBackground];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)setMap: (id) sender{
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

-(IBAction)manageBusiness:(id)sender{
    NSString *storyBoardId = @"ManageBusinessScene";
    
    ManageBusinessTableViewController *manageBusinessVC = [self.storyboard instantiateViewControllerWithIdentifier:storyBoardId];
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    
    PFQuery *query = [PFQuery queryWithClassName:@"Business"];
    [query whereKey:@"name" equalTo:self.business.name];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *currentBusiness, NSError *error) {
        if (!currentBusiness) {
            //TODO: Fix this with alert
            NSLog(@"The getFirstObject request failed.");
        } else {
            self.businessId = currentBusiness.objectId;
            
            appDelegate.data = self.businessId;
            
            [self.navigationController pushViewController:manageBusinessVC animated:YES];

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
