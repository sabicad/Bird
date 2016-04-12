//
//  RatingCell.m
//  flappyBird
//
//  Created by ... on 03/19/16.
//  Copyright © 2016 ... All rights reserved.
//

#import "RatingCell.h"

@interface RatingCell ()

@end

@implementation RatingCell

- (void)prepareForReuse
{
    self.position.text = @"";
    self.name.text = @"";
    self.rating.text = @"";
}

@end
