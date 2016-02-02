//
//  Business.m
//  CompanyDiscounts
//
//  Created by Margarita Ivancheva on 2/2/16.
//  Copyright © 2016 Telerik Academy. All rights reserved.
//

#import "Business.h"

@implementation Business

@synthesize name = _name;
@synthesize employeeLike = _employeeLike;

+(void)load{
    [self registerSubclass];
}

+(NSString *) parseClassName{
    return @"Business";
}

-(NSString *)name{
    return self[@"name"];
};

//-(NSString *)employeeLike{
//    return self[@"employeeLike"];
//};
//-(void)setEmployeeLike:(NSString *)employeeLike{
//    self[@"employeeLike"] = employeeLike;
//}

-(void)setName:(NSString *)name{
    self[@"name"] = name;
}

+(Business *) withName:(NSString *)name{
    Business *business = [Business object];
    business.name = name;
   // business.employeeLike = @"true";
    
    return business;
}

@end
