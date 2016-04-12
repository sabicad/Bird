//
//  SettingsView.m
//  flappyBird
//
//  Created by ... 03/23/16.
//  Copyright © 2016 ... All rights reserved.
//

#import "SettingsView.h"

@interface SettingsView()

@property (weak, nonatomic) IBOutlet UISegmentedControl *difficultySegmented;
@property (weak, nonatomic) IBOutlet UISegmentedControl *backgroundSegmented;

@end


@implementation SettingsView

#pragma mark - Lifecycle

- (void)awakeFromNib
{
    [self getUserDefaultsValueForSegmentedControl:self.difficultySegmented andKey:kValueDifficultyLevel];
    [self getUserDefaultsValueForSegmentedControl:self.backgroundSegmented andKey:kValueBackgroundStyle];
}

#pragma mark - Actions

- (IBAction)closeButtonAction:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(settingsViewProtocolCloseAction)]) {
        [self.delegate settingsViewProtocolCloseAction];
    }
}

- (IBAction)difficultySelected:(id)sender
{
    [self setUserDefaultsValue:self.difficultySegmented.selectedSegmentIndex forKey:kValueDifficultyLevel];
}

- (IBAction)backgroundSelected:(id)sender
{
    [self setUserDefaultsValue:self.backgroundSegmented.selectedSegmentIndex forKey:kValueBackgroundStyle];
}

#pragma mark - Private

- (void)getUserDefaultsValueForSegmentedControl:(UISegmentedControl *)segmented andKey:(NSString *)key
{
    NSNumber *value = [[NSUserDefaults standardUserDefaults] valueForKey:key];
    if (value) {
        segmented.selectedSegmentIndex = [value integerValue];
    } else {
        segmented.selectedSegmentIndex = 0;
    }
}

- (void)setUserDefaultsValue:(NSInteger)value forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:value] forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    self.isSomethingChanged = YES;
}

@end
