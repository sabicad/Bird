//
//  Bird.m
//  flappyBird
//
//  Created by ... on 03/19/16.
//  Copyright © 2016 ... All rights reserved.
//

#import "Bird.h"

@interface Bird ()

@property (strong, nonatomic) SKPhysicsBody *birdPhysicsBody;

@end

@implementation Bird

- (id)init
{
    if (self = [super init]) {
        NSMutableArray *birdFrames = [NSMutableArray array];
        
        SKTextureAtlas *birdAnimatedAtlas = [SKTextureAtlas atlasNamed:@"BirdImages"];
        int numImages = (int)birdAnimatedAtlas.textureNames.count;
        
        for (int i=1; i <= numImages; i++) {
            NSString *textureName = [NSString stringWithFormat:@"bird%d", i];
            SKTexture *temp = [birdAnimatedAtlas textureNamed:textureName];
            [birdFrames addObject:temp];
        }
        
        self = [Bird spriteNodeWithTexture:birdFrames[0]];
        
        SKAction *fly = [SKAction repeatActionForever:[SKAction animateWithTextures:birdFrames timePerFrame:kAnimationSpeedFrameChange resize:NO restore:YES]];
        
        self.birdPhysicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
        self.birdPhysicsBody.categoryBitMask = birdCategory;
        self.birdPhysicsBody.mass = kAnimationPhysicsBodyMass;
        
        [self runAction:fly];
    }
    
    return self;
}

- (void)addPhysicsBody
{
    [self setPhysicsBody:self.birdPhysicsBody];
}

- (void)jump
{
    [self.physicsBody setVelocity:CGVectorMake(0, 0)];
    [self.physicsBody applyImpulse:CGVectorMake(0, 40)];
}

- (void)update:(NSTimeInterval)currentTime
{
    self.zRotation = self.birdPhysicsBody.velocity.dy*M_PI_4*0.001;
}

@end
