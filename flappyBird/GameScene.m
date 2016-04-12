//
//  GameScene.m
//  flappyBird
//
//  Created by ... on 03/19/16.
//  Copyright © 2016 ... All rights reserved.
//

#import "GameScene.h"
#import "Bird.h"
#import "Background.h"
#import "Random.h"

@interface GameScene ()

@property (strong, nonatomic) Bird *bird;
@property (strong, nonatomic) Background *background;
@property (strong, nonatomic) Background *ground;

@property (strong, nonatomic) NSMutableArray *topTubes;
@property (strong, nonatomic) NSMutableArray *bottomTubes;

@property (strong, nonatomic) SKLabelNode *scoreNode;

@property (assign, nonatomic) BOOL isGameActive;

@property (assign, nonatomic) CGFloat screenWidth;
@property (assign, nonatomic) CGFloat screenHeight;

@property (assign, nonatomic) CGFloat score;
@property (assign, nonatomic) CGFloat bordersNumber;

@property (assign, nonatomic) CGFloat maxHeight;
@property (assign, nonatomic) CGFloat maxTubeHeight;
@property (assign, nonatomic) CGFloat minBottomTubeHeight;

@property (strong, nonatomic) UIImage *groundImage;

@end


@implementation GameScene

#pragma mark - Lifecycle

- (id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        self.topTubes = [[NSMutableArray alloc] init];
        self.bottomTubes = [[NSMutableArray alloc] init];
        
        self.groundImage = [UIImage imageNamed:@"ground"];
        
        self.physicsWorld.contactDelegate = self;
        
        [self preparatoryCalculations];
     
        [self startGame];
    }
    
    return self;
}

- (void)startGame
{
    if (!self.bird) {
        self.isGameActive = NO;
        
        [self addBackGround];
        [self addGround];
        [self addBird];

        [self setNonGameZPosition];
    } else {
        [self removeAllChildren];
        
        self.isGameActive = YES;
        
        [self addBackGround];
        [self addScore];

        self.background.zPosition = 1;
        
        [self addTubes];
        [self addGround];
        [self addBird];
        
        [self setGameZPositions];
    }
}

#pragma mark - SKScene override

- (void)update:(CFTimeInterval)currentTime
{
    [self.background update:currentTime];
    [self.ground update:currentTime];
    [self.bird update:currentTime];
    
    if (!self.isGameActive) {
        return;
    }
    
    [self updateTubes];
    [self updateScore];
}

#pragma mark - Private

- (void)addBackGround
{
    self.background = [[Background alloc]initBackgroundWithImage:[[SettingsManager shared] getBackgroundImageName] width:self.screenWidth andYPosition:self.groundImage.size.height];
    
    self.background.scrollSpeed = kAnimationSpeedBackground;
    self.background.anchorPoint = CGPointMake(0, 0.3);

    self.background.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    self.background.physicsBody.categoryBitMask = backgroundCategory;
    self.background.physicsBody.contactTestBitMask = birdCategory;
    
    [self addChild:self.background];
}

- (void)addBird
{
    self.bird = [[Bird alloc] init];
  
    self.bird.position = CGPointMake(50, self.screenHeight/2);
    
    [self addChild:self.bird];
}

- (void)addGround
{
    self.ground = [[Background alloc] initBackgroundWithImage:@"ground" width:self.screenWidth andYPosition:0];
    
    self.ground.scrollSpeed = [[SettingsManager shared] getSpeed];
    self.ground.anchorPoint = CGPointZero;
    
    self.ground.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.ground.frame];
    self.ground.physicsBody.categoryBitMask = groundCategory;
    self.ground.physicsBody.contactTestBitMask = birdCategory;
    
    [self addChild:self.ground];
}

- (void)addScore
{
    self.score = 0;
    self.scoreNode = [SKLabelNode labelNodeWithFontNamed:@"Arial-BoldMT"];
   
    self.scoreNode.text = [NSString stringWithFormat:@"%d", (int)self.score];
    self.scoreNode.position = CGPointMake(self.screenWidth/2, self.screenHeight*0.75);
    self.scoreNode.fontSize = 25;

    [self addChild:self.scoreNode];
}

- (void)addTubes
{
    for (int i = 0; i < self.bordersNumber; i++) {
        SKSpriteNode * topTube = [SKSpriteNode spriteNodeWithImageNamed:@"tubeGreenTop"];
        topTube.anchorPoint = CGPointZero;
    
        SKSpriteNode * bottomTube = [SKSpriteNode spriteNodeWithImageNamed:@"tubeGreenBottom"];
        bottomTube.anchorPoint = CGPointZero;

        [self.topTubes addObject:topTube];
        [self.bottomTubes addObject:bottomTube];

        [self addChild:topTube];
        [self addChild:bottomTube];
        
        topTube.zPosition = 2;
        bottomTube.zPosition = 2;
        
        if (i == 0) {
            [self setTopTube:topTube andBottomTube:bottomTube withOffset:self.screenWidth + [[SettingsManager shared]getInitialOffset]];
        } else {
            [self setTopTube:topTube andBottomTube:bottomTube withOffset:(self.screenWidth + [[SettingsManager shared]getInitialOffset]) + i * (topTube.size.width + [[SettingsManager shared]getDistanceBetweenBorders])];
        }
    }
}

- (void)preparatoryCalculations
{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    if (screenSize.width < screenSize.height) {
        self.screenWidth = screenSize.width;
        self.screenHeight = screenSize.height;
    } else {
        self.screenWidth = screenSize.height;
        self.screenHeight = screenSize.width;
    }
    
    self.maxHeight = self.screenHeight - self.groundImage.size.height;
    self.maxTubeHeight = self.maxHeight - [[SettingsManager shared] getDistanceBetweenTubes] + kDistanceMinimumTubeHeight;
    self.minBottomTubeHeight = self.groundImage.size.height + kDistanceMinimumTubeHeight;
    self.bordersNumber = ceilf(self.screenWidth / [[SettingsManager shared]getDistanceBetweenBorders]);
}

- (void)setNonGameZPosition
{
    CGFloat i = 1;
    
    self.background.zPosition = i;
    self.ground.zPosition = i+1;
    self.bird.zPosition = i+2;
}

- (void)setGameZPositions
{
    CGFloat i = 3;
    
    self.bird.zPosition = i;
    self.ground.zPosition = i+1;
    self.scoreNode.zPosition = i+2;
}

- (void)setTopTube:(SKSpriteNode *)topTube andBottomTube:(SKSpriteNode *)bottomTube withOffset:(CGFloat)xOffset
{
    CGFloat randomBottomTubeHeight = [[Random alloc] randomFloatNumberBetween:self.minBottomTubeHeight andHigherNumber:self.maxTubeHeight];
    
    CGFloat bottomTubePosition = randomBottomTubeHeight - bottomTube.size.height;
    CGFloat topTubePosition = randomBottomTubeHeight + [[SettingsManager shared] getDistanceBetweenTubes];
    
    bottomTube.position = CGPointMake(xOffset, bottomTubePosition);
    bottomTube.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(0,0, bottomTube.frame.size.width, bottomTube.frame.size.height)];
    bottomTube.physicsBody.categoryBitMask = bordersCategory;
    bottomTube.physicsBody.contactTestBitMask = birdCategory;
    
    topTube.position = CGPointMake(xOffset, topTubePosition);
    topTube.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(0,0, topTube.frame.size.width, topTube.frame.size.height)];
    topTube.physicsBody.categoryBitMask = bordersCategory;
    topTube.physicsBody.contactTestBitMask = birdCategory;
}

- (void)updateScore
{
    for (int i = 0; i < self.bordersNumber; i++) {
        SKSpriteNode *topTube = self.topTubes[i];
        
        if (self.bird.position.x < (topTube.position.x + topTube.size.width) && self.bird.position.x > (topTube.position.x + topTube.size.width - [[SettingsManager shared] getSpeed])) {
            self.score += 1;
            self.scoreNode.text = [NSString stringWithFormat:@"%d", (int)self.score];
        }
    }
}

- (void)updateTubes
{
    for (int i = 0; i < self.bordersNumber; i++) {
        SKSpriteNode *topTube = self.topTubes[i];
        SKSpriteNode *bottomTube = self.bottomTubes[i];
        
        if (topTube.position.x < -topTube.size.width) {
            CGFloat maxPosition = 0;
            
            for (SKSpriteNode *lastTube in self.topTubes) {
                if (lastTube.position.x > maxPosition) {
                    maxPosition = lastTube.position.x;
                }
            }
            [self setTopTube:topTube andBottomTube:bottomTube withOffset:(maxPosition + topTube.frame.size.width + [[SettingsManager shared]getDistanceBetweenBorders])];
        }
        
        CGFloat difficultySpeed = [[SettingsManager shared] getSpeed];
        topTube.position = CGPointMake(topTube.position.x - difficultySpeed, topTube.position.y);
        bottomTube.position = CGPointMake(bottomTube.position.x - difficultySpeed, bottomTube.position.y);
    }
}

#pragma mark - Actions

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    if ([touch.view isKindOfClass:[SKView class]]) {
        if (!self.isGameActive) {
            if ([self.gameSceneDelegate respondsToSelector:@selector(gameSceneProtocolGameStartAction)]) {
                [self.gameSceneDelegate gameSceneProtocolGameStartAction];
            }
            [self startGame];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                if ([self.gameSceneDelegate respondsToSelector:@selector(gameSceneProtocolBirdPhysicBodyAdd)]) {
                    [self.gameSceneDelegate gameSceneProtocolBirdPhysicBodyAdd];
                }
                [self.bird addPhysicsBody];
            });
        } else {
            [self.bird jump];
        }
    }
}

#pragma mark - PhysicsContact Delegate

- (void)didBeginContact:(SKPhysicsContact *)contact
{
    self.isGameActive = NO;
    
    [[NSUserDefaults standardUserDefaults] setInteger:self.score forKey:kValueCurrentScore];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if ([self.gameSceneDelegate respondsToSelector:@selector(gameSceneProtocolGameOverAction)]) {
        [self.gameSceneDelegate gameSceneProtocolGameOverAction];
    }
}

@end
