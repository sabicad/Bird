//
//  SettingsManager.m
//  flappyBird
//
//  Created by ... on 03/23/16.
//  Copyright © 2016 ... All rights reserved.
//

#import "SettingsManager.h"

@interface SettingsManager ()

@end

@implementation SettingsManager

+ (instancetype)shared
{
    static SettingsManager *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[SettingsManager alloc] init];
    });
    return shared;
}

- (NSString *)getBackgroundImageName
{
    NSString *name;
    
    NSNumber *value = [[NSUserDefaults standardUserDefaults] valueForKey:kValueBackgroundStyle];
    if (value) {
        self.backgroundKind = [value integerValue];
    } else {
        self.backgroundKind = 0;
    }
    
    switch (self.backgroundKind) {
        case BackgroundTypeEnumDay:
            name = @"backgroundDay";
            break;
        case BackgroundTypeEnumNight:
            name = @"backgroundNight";
            break;
    }
    
    return name;
}

- (CGFloat)getDistanceBetweenTubes
{
    CGFloat distance;
    
    NSNumber *value = [[NSUserDefaults standardUserDefaults] valueForKey:kValueDifficultyLevel];
    if (value) {
        self.difficultyKind = [value integerValue];
    } else {
        self.difficultyKind = 0;
    }
    
    switch (self.difficultyKind) {
        case DifficultyLevelEnumEasy:
            distance = kDistanceMinimumSpaceBetweenTubesEasy;
            break;
        case DifficultyLevelEnumMedium:
            distance = kDistanceMinimumSpaceBetweenTubesMedium;
            break;
        case DifficultyLevelEnumHard:
            distance = kDistanceMinimumSpaceBetweenTubesHard;
            break;
    }
    
    return distance;
}

- (CGFloat)getSpeed
{
    BOOL isSimulator;
    #ifdef __i386__
        isSimulator = YES;
    #endif

    CGFloat speed;
    
    NSNumber *value = [[NSUserDefaults standardUserDefaults] valueForKey:kValueDifficultyLevel];
    if (value) {
        self.difficultyKind = [value integerValue];
    } else {
        self.difficultyKind = 0;
    }
    
    switch (self.difficultyKind) {
        case DifficultyLevelEnumEasy:
            speed = isSimulator ? kAnimationSpeedGroundEasySimulator : kAnimationSpeedGroundEasy;
            break;
        case DifficultyLevelEnumMedium:
            speed = isSimulator ? kAnimationSpeedGroundMediumSimulator : kAnimationSpeedGroundMedium;
            break;
        case DifficultyLevelEnumHard:
            speed = isSimulator ? kAnimationSpeedGroundHardSimulator : kAnimationSpeedGroundHard;
            break;
    }
    
    return speed;
}

- (CGFloat)getInitialOffset
{
    CGFloat offset;
    
    NSNumber *value = [[NSUserDefaults standardUserDefaults] valueForKey:kValueDifficultyLevel];
    if (value) {
        self.difficultyKind = [value integerValue];
    } else {
        self.difficultyKind = 0;
    }
    
    switch (self.difficultyKind) {
        case DifficultyLevelEnumEasy:
            offset = kDistanceInitialTubeOffsetEasy;
            break;
        case DifficultyLevelEnumMedium:
            offset = kDistanceInitialTubeOffsetMedium;
            break;
        case DifficultyLevelEnumHard:
            offset = kDistanceInitialTubeOffsetHard;
            break;
    }
    
    return offset;
}

- (CGFloat)getDistanceBetweenBorders
{
    CGFloat offset;
    
    NSNumber *value = [[NSUserDefaults standardUserDefaults] valueForKey:kValueDifficultyLevel];
    if (value) {
        self.difficultyKind = [value integerValue];
    } else {
        self.difficultyKind = 0;
    }
    
    switch (self.difficultyKind) {
        case DifficultyLevelEnumEasy:
            offset = kDistanceBetweenBordersEasy;
            break;
        case DifficultyLevelEnumMedium:
            offset = kDistanceBetweenBordersMedium;
            break;
        case DifficultyLevelEnumHard:
            offset = kDistanceBetweenBordersHard;
            break;
    }
    
    return offset;
}

@end
