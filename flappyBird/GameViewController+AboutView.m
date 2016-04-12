//
//  GameViewController+AboutView.m
//  flappyBird
//
//  Created by ... on 03/19/16.
//  Copyright © 2016 ... All rights reserved.
//

#import "GameViewController.h"

@implementation GameViewController (AboutView)

- (void)showAboutView
{
    if ([self.view.subviews.lastObject isKindOfClass:[AboutView class]]) {
        return;
    }
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([AboutView class]) owner:self options:nil];
    self.aboutView = array[0];
    self.aboutView.delegate = self;
    
    self.aboutView.frame = self.view.bounds;
    [self.view addSubview:self.aboutView];
}

#pragma mark - LeaderBoard Delegate

- (void)aboutViewProtocolCloseAction
{
    self.menuButton.hidden = NO;
    [self.aboutView removeFromSuperview];
//    self.aboutView = nil;
    
}

@end
