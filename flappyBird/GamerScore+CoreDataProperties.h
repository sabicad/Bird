//
//  GamerScore+CoreDataProperties.h
//  flappyBird
//
//  Created by ... on 03/19/16.
//  Copyright © 2016 ... All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "GamerScore.h"

NS_ASSUME_NONNULL_BEGIN

@interface GamerScore (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *score;

- (NSString *)getScore;

@end

NS_ASSUME_NONNULL_END
