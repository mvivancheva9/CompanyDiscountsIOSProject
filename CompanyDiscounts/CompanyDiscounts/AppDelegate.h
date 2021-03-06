//
//  AppDelegate.h
//  CompanyDiscounts
//
//  Created by Margarita Ivancheva on 2/1/16.
//  Copyright © 2016 Telerik Academy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>



@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong, nonatomic) NSString* data;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

