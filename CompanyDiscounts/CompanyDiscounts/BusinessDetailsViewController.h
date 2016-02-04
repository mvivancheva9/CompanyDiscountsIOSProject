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

@interface BusinessDetailsViewController : ViewController

@property (strong, nonatomic) Business *business;
@property (strong, nonatomic) Location *location;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
