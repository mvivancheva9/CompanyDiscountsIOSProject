//
//  AddLocationViewController.h
//  CompanyDiscounts
//
//  Created by Margarita Ivancheva on 2/3/16.
//  Copyright © 2016 Telerik Academy. All rights reserved.
//

#import "ViewController.h"
#include <MapKit/MapKit.h>
#import "Business.h"

@interface AddLocationViewController : ViewController{
    MKMapView *mapView;
}

@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) Business *business;

-(IBAction)setMap: (id) sender;

@end
