//
//  GameViewController+SettingsView.m
//  flappyBird
//
//  Created by ... on 03/19/16.
//  Copyright © 2016 ... All rights reserved.
//

#import "GameViewController.h"

@implementation GameViewController (SettingsView)

- (void)showSettingsView
{
    if ([self.view.subviews.lastObject isKindOfClass:[SettingsView class]]) {
        return;
    }
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([SettingsView class]) owner:self options:nil];
    self.settingsView = array[0];
    self.settingsView.delegate = self;
    
    self.settingsView.frame = self.view.bounds;
    [self.view addSubview:self.settingsView];
}

@end
