//
//  Random.m
//  flappyBird
//
//  Created by ... on 03/19/16.
//  Copyright © 2016 ... All rights reserved.
//

#import "Random.h"

@implementation Random

- (CGFloat)randomFloatNumberBetween:(CGFloat)lowerNumber andHigherNumber:(CGFloat)higherNumber
{
    return ((CGFloat)arc4random() / ARC4RANDOM_MAX) * (higherNumber-lowerNumber) + lowerNumber;
}

@end
