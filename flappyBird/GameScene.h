//
//  GameScene.h
//  flappyBird
//
//  Created by ... on 03/19/16.
//  Copyright © 2016 ... All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@protocol GameSceneProtocol <SKSceneDelegate>

- (void)gameSceneProtocolGameStartAction;
- (void)gameSceneProtocolBirdPhysicBodyAdd;
- (void)gameSceneProtocolGameOverAction;

@end

@interface GameScene : SKScene<SKPhysicsContactDelegate>

@property (strong, nonatomic) id<GameSceneProtocol> gameSceneDelegate;

@end
