//
//  GameViewController+MenuView.m
//  flappyBird
//
//  Created by ... on 03/19/16.
//  Copyright © 2016 ... All rights reserved.
//

#import "GameViewController.h"

@implementation GameViewController (MenuView)

- (void)showMenuView
{
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MenuView class]) owner:self options:nil];
    self.menuView = array[0];
    self.menuView.delegate = self;
    
    CGRect frame = self.menuContainerview.bounds;
    frame.origin.y = 35;
    
    self.menuView.frame = frame;
    [self.menuContainerview addSubview:self.menuView];
 
    [self slideMenuIfNeeded];
}

- (void)closeMenu
{
    [self slideMenuIfNeeded];
    [self.menuView removeFromSuperview];
    self.menuView = nil;
}

#pragma mark - MenuView Delegate

- (void)menuViewProtocolSettingsAction
{
    [self quickCloseMenu];
    [self showSettingsView];
}

- (void)menuViewProtocolAboutAction
{
    [self quickCloseMenu];
    [self showAboutView];
}

- (void)menuViewProtocolLeaderboardAction
{
    [self quickCloseMenu];
    [self showLeaderBoardView];
}

#pragma mark - Private

- (void)slideMenuIfNeeded
{
    [self.menuFrameView layoutIfNeeded];
    [UIView animateWithDuration:0.8
                          delay:0.0
                        options:UIViewAnimationOptionAllowAnimatedContent
                     animations:^{
                         self.constraintMenuOffset.constant = self.constraintMenuOffset.constant == -200 ? 0 : -200;
                         self.constraintMenuWidth.constant = self.constraintMenuWidth.constant == 255 ? 200 : 255;
                         self.constraintMenuContainerRight.constant = self.constraintMenuContainerRight.constant == 55 ? 0 : 55;
                         [self.menuFrameView layoutIfNeeded];
                     }
                     completion:nil];
}

- (void)quickCloseMenu
{
    self.constraintMenuOffset.constant = -200;
    self.constraintMenuWidth.constant = 255;
    self.constraintMenuContainerRight.constant = 55;
    self.menuButton.hidden = YES;
}

@end
