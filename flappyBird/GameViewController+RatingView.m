//
//  GameViewController+RatingView.m
//  flappyBird
//
//  Created by ... on 03/19/16.
//  Copyright © 2016 ... All rights reserved.
//

#import "GameViewController.h"

@implementation GameViewController (RatingView)

- (void)showRatingView
{
    if ([self.view.subviews.lastObject isKindOfClass:[RatingView class]]) {
        return;
    }
    
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([RatingView class]) owner:self options:nil];
    self.ratingView = array[0];
    self.ratingView.delegate = self;
    
    self.ratingView.frame = self.view.bounds;
    [self.view addSubview:self.ratingView];
}

#pragma mark - RatingView Delegate

- (void)ratingViewProtocolCloseAction
{
    self.menuButton.hidden = NO;
    [self.ratingView removeFromSuperview];
    self.ratingView = nil;
    [self setGameInfoHidden:NO];
}

@end
