//
//  Background.h
//  flappyBird
//
//  Created by ... on 03/19/16.
//  Copyright © 2016 ... All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Background : SKSpriteNode

@property (assign, nonatomic) CGFloat scrollSpeed;

- (id)initBackgroundWithImage:(NSString *)image width:(CGFloat)width andYPosition:(CGFloat)yPosition;
- (void)update:(NSTimeInterval)currentTime;

@end
