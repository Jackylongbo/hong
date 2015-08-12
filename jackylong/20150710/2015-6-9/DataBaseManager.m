//
//  DataBaseManager.m
//  dianjinsuo
//
//  Created by 典盟金融 on 15-7-27.
//  Copyright (c) 2015年 rohool. All rights reserved.
//

#import "DataBaseManager.h"

@implementation DataBaseManager
@synthesize managedobjectmodel;
@synthesize managedobjectcontext;
@synthesize persistentstorecoordinator;

//获取当前应用的DocumentDirectory
-(NSURL*)applicationDocumentDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentationDirectory inDomains:NSUserDomainMask]lastObject];
}

-(NSManagedObjectContext*)managedObjectContext
{
    if (managedobjectcontext!=nil) {
        return managedobjectcontext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator!=nil) {
        managedobjectcontext = [[NSManagedObjectContext alloc] init];
        [managedobjectcontext setPersistentStoreCoordinator:coordinator];
    }
    return managedobjectcontext;
}

-(NSPersistentStoreCoordinator*)persistentStoreCoordinator
{
    if (persistentstorecoordinator!=nil) {
        return persistentstorecoordinator;
    }
    NSURL *storeUrl = [[self applicationDocumentDirectory]URLByAppendingPathComponent:@"bid.sqlite3"];
    NSError *error = nil;
    persistentstorecoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if ([persistentstorecoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error])
    {
        abort();
    }
    return persistentstorecoordinator;
}

-(NSManagedObjectModel*)managedObjectModel
{
    if (managedobjectmodel!=nil) {
        return managedobjectmodel;
    }
    NSURL *modelURL = [[NSBundle mainBundle]URLForResource:@"Bid" withExtension:@"momd"];
    managedobjectmodel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return managedobjectmodel;
}

@end
