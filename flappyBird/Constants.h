//
//  Constants.h
//  flappyBird
//
//  Created by ... on 03/19/16.
//  Copyright © 2016 ... All rights reserved.
//

#import <UIKit/UIKit.h>

#define ARC4RANDOM_MAX 0x100000000

#define kAnimationSpeedBackground 1.0
#define kAnimationSpeedFrameChange 0.2

#define kAnimationSpeedGroundEasy 2.3
#define kAnimationSpeedGroundMedium 2.6
#define kAnimationSpeedGroundHard 3.0
#define kAnimationSpeedGroundEasySimulator 3
#define kAnimationSpeedGroundMediumSimulator 4
#define kAnimationSpeedGroundHardSimulator 5

#define kAnimationPhysicsBodyMass 0.16

#define kDistanceBetweenBordersEasy 100
#define kDistanceBetweenBordersMedium 130
#define kDistanceBetweenBordersHard 160

#define kDistanceInitialTubeOffsetEasy 130
#define kDistanceInitialTubeOffsetMedium 200
#define kDistanceInitialTubeOffsetHard 270

#define kDistanceMinimumSpaceBetweenTubesEasy 150
#define kDistanceMinimumSpaceBetweenTubesMedium 130
#define kDistanceMinimumSpaceBetweenTubesHard 110

#define kDistanceMinimumTubeHeight 35

#define kMedalRatingBronzeMax 20
#define kMedalRatingSilverMax 30
#define kMedalRatingGoldMax 40

#define kValueCurrentScore @"CurrentScore"
#define kValueDifficultyLevel @"DifficultyLevel"
#define kValueBackgroundStyle @"BackgroundStyle"

static const uint32_t backgroundCategory = 0x1 << 0;
static const uint32_t birdCategory = 0x1 << 1;
static const uint32_t groundCategory = 0x1 << 2;
static const uint32_t bordersCategory = 0x1 << 3;