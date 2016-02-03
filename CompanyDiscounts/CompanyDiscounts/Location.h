//
//  Location.h
//  CompanyDiscounts
//
//  Created by Margarita Ivancheva on 2/3/16.
//  Copyright © 2016 Telerik Academy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>


@interface Location : PFObject <PFSubclassing>

@property PFGeoPoint *point;
@property (strong, nonatomic) NSString *businessId;


+(NSString*) parseClassName;

+(Location *) withGeoPoint:(PFGeoPoint *)point
         andWithBusinessId:(NSString *)businessId;

@end
