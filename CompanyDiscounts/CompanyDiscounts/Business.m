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
@synthesize discount = _discount;

+(void)load{
    [self registerSubclass];
}

+(NSString *) parseClassName{
    return @"Business";
}

-(NSString *)name{
    return self[@"name"];
};

-(NSString *)discount{
    return self[@"discount"];
};
-(void)setDiscount:(NSString *)discount{
    self[@"discount"] = discount;
}

-(void)setName:(NSString *)name{
    self[@"name"] = name;
}

+(Business *) withName:(NSString *)name
       andWithDiscount:(NSString *)discount{
    Business *business = [Business object];
    business.name = name;
    business.discount = discount;
   // business.employeeLike = @"true";
    
    return business;
}

+(Business *) withName:(NSString *)name{
    Business *business = [Business object];
    business.name = name;
    
    return business;
}

@end
