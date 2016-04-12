//
//  GamerScore+CoreDataProperties.m
//  flappyBird
//
//  Created by ... on 03/19/16.
//  Copyright © 2016 ... All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "GamerScore+CoreDataProperties.h"

@implementation GamerScore (CoreDataProperties)

@dynamic name;
@dynamic score;

- (NSString *)getScore
{
    return self.score.stringValue;
}

@end
