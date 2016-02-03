//
//  Location.m
//  CompanyDiscounts
//
//  Created by Margarita Ivancheva on 2/3/16.
//  Copyright © 2016 Telerik Academy. All rights reserved.
//

#import "Location.h"

@implementation Location

@synthesize businessId = _businessId;
@synthesize point = _point;

+(void)load{
    [self registerSubclass];
}

+(NSString *) parseClassName{
    return @"Location";
}

-(NSString *)businessId{
    return self[@"businessId"];
};

-(void)setBusinessId:(NSString *)businessId{
    self[@"businessId"] = businessId;
}

-(PFGeoPoint *)point{
    return self[@"point"];
};

-(void)setPoint:(PFGeoPoint *)point{
    self[@"point"] = point;
};

+(Location *) withGeoPoint:(PFGeoPoint *)point andWithBusinessId:(NSString *)businessId{
    
    Location *location = [Location object];
    location.point = point;
    location.businessId = businessId;
    
    return location;    
};

@end
