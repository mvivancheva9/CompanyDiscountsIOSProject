//
//  BusinessDetailsViewController.h
//  CompanyDiscounts
//
//  Created by Margarita Ivancheva on 2/4/16.
//  Copyright © 2016 Telerik Academy. All rights reserved.
//

#import "ViewController.h"
#import "Business.h"
#import "Location.h"
#import <MapKit/MapKit.h>

@interface BusinessDetailsViewController : ViewController <MKMapViewDelegate> {
    MKMapView *mapView;
}

@property (strong, nonatomic) Business *business;
@property (strong, nonatomic) Location *location;
@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property CLLocationCoordinate2D tappedCoord;

-(IBAction)GetLocation: (id)sender;

- (IBAction)setMap:(id)sender;

- (IBAction)getDirections:(id)sender;
@end
