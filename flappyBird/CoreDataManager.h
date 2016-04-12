//
//  CoreDataManager.h
//  flappyBird
//
//  Created by ... on 03/19/16.
//  Copyright © 2016 ... All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreDataManager : NSObject

+ (instancetype)sharedManager;
- (id)objectWithEntityName:(NSString *)entity;
- (void)saveContext;
- (NSArray *)getRatings;
- (id)getMaximumScore;

@end
