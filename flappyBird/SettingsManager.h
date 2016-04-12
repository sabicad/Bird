//
//  SettingsManager.h
//  flappyBird
//
//  Created by ... on 03/23/16.
//  Copyright © 2016 ... All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, BackgroundTypeEnum)
{
    BackgroundTypeEnumDay,
    BackgroundTypeEnumNight,
};

typedef NS_ENUM(NSInteger, DifficultyLevelEnum)
{
    DifficultyLevelEnumEasy,
    DifficultyLevelEnumMedium,
    DifficultyLevelEnumHard
};

@interface SettingsManager : NSObject

@property (assign, nonatomic) BackgroundTypeEnum backgroundKind;
@property (assign, nonatomic) DifficultyLevelEnum difficultyKind;

+ (instancetype)shared;

- (NSString *)getBackgroundImageName;
- (CGFloat)getDistanceBetweenTubes;
- (CGFloat)getSpeed;
- (CGFloat)getInitialOffset;
- (CGFloat)getDistanceBetweenBorders;

@end
