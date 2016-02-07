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
@property (strong, nonatomic) NSString *businessId;

-(IBAction)setMap: (id) sender;

-(IBAction)manageBusiness:(id)sender;

@end
