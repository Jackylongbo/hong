//
//  DataBaseManager.h
//  dianjinsuo
//
//  Created by 典盟金融 on 15-7-27.
//  Copyright (c) 2015年 rohool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DataBaseManager : NSObject

@property (nonatomic ,retain)NSManagedObjectContext *managedobjectcontext;
@property (nonatomic ,retain)NSManagedObjectModel *managedobjectmodel;
@property (nonatomic ,retain)NSPersistentStoreCoordinator *persistentstorecoordinator;

-(NSURL*)applicationDocumentDirectory;
-(NSManagedObjectContext*)managedObjectContext;
-(NSPersistentStoreCoordinator*)persistentStoreCoordinator;
-(NSManagedObjectModel*)managedObjectModel;


@end
