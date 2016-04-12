//
//  MenuView.m
//  flappyBird
//
//  Created by ... 03/23/16.
//  Copyright © 2016 ... All rights reserved.
//

#import "MenuView.h"

@interface MenuView()


@end


@implementation MenuView

- (IBAction)settingsButtonAction:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(menuViewProtocolSettingsAction)]) {
        [self.delegate menuViewProtocolSettingsAction];
    }
}

- (IBAction)aboutButtonAction:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(menuViewProtocolAboutAction)]) {
        [self.delegate menuViewProtocolAboutAction];
    }
}

- (IBAction)leaderboardButtonAction:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(menuViewProtocolLeaderboardAction)]) {
        [self.delegate menuViewProtocolLeaderboardAction];
    }
}


@end
