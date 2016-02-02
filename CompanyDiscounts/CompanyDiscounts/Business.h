//
//  Business.h
//  CompanyDiscounts
//
//  Created by Margarita Ivancheva on 2/2/16.
//  Copyright © 2016 Telerik Academy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface Business : PFObject <PFSubclassing>

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *employeeLike;

+(NSString*) parseClassName;

+(Business *) withName:(NSString *)name;
@end
