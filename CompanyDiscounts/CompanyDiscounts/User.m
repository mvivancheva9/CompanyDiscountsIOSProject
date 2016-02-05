//
//  User.m
//  CompanyDiscounts
//
//  Created by Margarita Ivancheva on 2/5/16.
//  Copyright © 2016 Telerik Academy. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize username = _username;
@synthesize password = _password;

+(void)load{
    [self registerSubclass];
}

+(NSString *) parseClassName{
    return @"User";
}

-(NSString *)username{
    return self[@"username"];
};

-(void)setUsername:(NSString *)username{
    self[@"username"] = username;
}

-(NSString *)password{
    return self[@"password"];
};

-(void)setPassword:(NSString *)password{
    self[@"password"] = password;
}

+(User *) withUsername:(NSString *)username andWithPassword:(NSString *)password{
    User *user = [User object];
    user.username = username;
    user.password = password;
    
    return user;
}
@end
