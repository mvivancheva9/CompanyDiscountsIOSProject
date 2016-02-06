//
//  User.h
//  CompanyDiscounts
//
//  Created by Margarita Ivancheva on 2/5/16.
//  Copyright © 2016 Telerik Academy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface User : PFObject <PFSubclassing>

@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *password;

+(NSString *) parseClassName;

+(User *) withUsername:(NSString *)username
       andWithPassword:(NSString *)password;

@end
