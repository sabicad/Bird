//
//  GameViewController+LeaderBoardView.m
//  flappyBird
//
//  Created by ... on 03/19/16.
//  Copyright © 2016 ... All rights reserved.
//

#import "GameViewController.h"

@implementation GameViewController (LeaderBoardView)

- (void)showLeaderBoardView
{
    if ([self.view.subviews.lastObject isKindOfClass:[LeaderBoardView class]]) {
        return;
    }
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LeaderBoardView class]) owner:self options:nil];
    self.leaderBoardView = array[0];
    self.leaderBoardView.delegate = self;
    
    self.leaderBoardView.frame = self.view.bounds;
    [self.view addSubview:self.leaderBoardView];
}

#pragma mark - LeaderBoard Delegate

- (void)leaderBoardViewProtocolCloseAction
{
    self.menuButton.hidden = NO;
    [self.leaderBoardView removeFromSuperview];
    self.leaderBoardView = nil;
}

@end
