//
//  CoreDataManager.m
//  flappyBird
//
//  Created by ... on 03/19/16.
//  Copyright © 2016 ... All rights reserved.
//

#import "CoreDataManager.h"
#import <CoreData/CoreData.h>
#import "GamerScore.h"

@interface CoreDataManager ()

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

@implementation CoreDataManager

+ (instancetype)sharedManager
{
    static CoreDataManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[CoreDataManager alloc] init];
    });
    return sharedManager;
}

- (id)objectWithEntityName:(NSString *)entity
{
    return [[NSClassFromString(entity) alloc] initWithEntity:[NSEntityDescription entityForName:entity
                                                                         inManagedObjectContext:[[CoreDataManager sharedManager] managedObjectContext]]
                              insertIntoManagedObjectContext:[[CoreDataManager sharedManager] managedObjectContext]];
}

- (NSArray *)getRatings
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"GamerScore" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"score" ascending:NO]]];
    
    return [self executeFetchRequest:fetchRequest];
}

- (id)getMaximumScore
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"GamerScore"];
    
    fetchRequest.fetchLimit = 1;
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"score" ascending:NO]];

    id gamerScore = [self executeFetchRequest:fetchRequest].firstObject;
    
    return gamerScore;
}

- (NSArray *)executeFetchRequest:(NSFetchRequest *)fetchRequest
{
    NSError *error;
    NSArray *array = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (error) {
        NSLog(@"ERROR: %@", error);
    }
    
    return array;
}

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Flappy" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"flappy.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

- (void)saveContext
{
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


@end
