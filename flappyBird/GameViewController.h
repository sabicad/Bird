//
//  GameViewController.h
//  flappyBird
//
//  Created by ... on 03/19/16.
//  Copyright © 2016 ... All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

#import "AboutView.h"
#import "LeaderBoardView.h"
#import "GameScene.h"
#import "RatingView.h"
#import "SettingsView.h"
#import "MenuView.h"

@interface GameViewController : UIViewController <GameSceneProtocol, SettingsViewProtocol>

@property (strong, nonatomic) AboutView *aboutView;
@property (strong, nonatomic) LeaderBoardView *leaderBoardView;
@property (strong, nonatomic) MenuView *menuView;
@property (strong, nonatomic) RatingView *ratingView;
@property (strong, nonatomic) SettingsView *settingsView;

@property (weak, nonatomic) IBOutlet UIView *menuContainerview;

@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintMenuOffset;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintMenuWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintMenuContainerRight;
@property (weak, nonatomic) IBOutlet UIView *menuFrameView;

- (void)isGetReadyImageHidden:(BOOL)value;
- (void)setGameInfoHidden:(BOOL)value;

@end

@interface GameViewController (AboutView) <AboutViewProtocol>

- (void)showAboutView;

@end

@interface GameViewController (LeaderBoardView) <LeaderBoardViewProtocol>

- (void)showLeaderBoardView;

@end

@interface GameViewController (MenuView) <MenuViewProtocol>

- (void)showMenuView;
- (void)closeMenu;

@end

@interface GameViewController (RatingView) <RatingViewProtocol>

- (void)showRatingView;

@end

@interface GameViewController (SettingsView)

- (void)showSettingsView;

@end