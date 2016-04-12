//
//  Bird.h
//  flappyBird
//
//  Created by ... on 03/19/16.
//  Copyright © 2016 ... All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Bird : SKSpriteNode

- (void)addPhysicsBody;
- (void)jump;
- (void)update:(NSTimeInterval)currentTime;

@end
