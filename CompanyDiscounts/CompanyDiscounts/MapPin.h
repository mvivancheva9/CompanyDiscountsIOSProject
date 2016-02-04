//
//  MapPin.h
//  CompanyDiscounts
//
//  Created by Margarita Ivancheva on 2/3/16.
//  Copyright © 2016 Telerik Academy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapPin : NSObject <MKAnnotation>{

    CLLocationCoordinate2D coordinate;
    NSString* title;
    NSString* subtitle;
}

@property(nonatomic, assign) CLLocationCoordinate2D coordinate;
@property(nonatomic, copy) NSString* title;
@property(nonatomic, copy) NSString* subTitle;

@end
