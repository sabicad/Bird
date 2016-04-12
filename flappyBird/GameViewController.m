//
//  GameViewController.m
//  flappyBird
//
//  Created by ... on 03/19/16.
//  Copyright © 2016 ... All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"

@interface GameViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *instructionImage;
@property (weak, nonatomic) IBOutlet UIImageView *getReadyImage;

@end

@implementation GameViewController

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self isGetReadyImageHidden:YES];
    [self setGameInfoHidden:NO];
    
    [self createScene];
}

#pragma mark - Actions

- (IBAction)menuButtonAction:(id)sender
{
    [self showMenuView];
}

#pragma mark - Mutators

- (void)isGetReadyImageHidden:(BOOL)value
{
    self.getReadyImage.hidden = value;
}

- (void)setGameInfoHidden:(BOOL)value
{
    self.instructionImage.hidden = value;
    self.menuView.hidden = value;
    self.menuButton.hidden = value;
}

#pragma mark - Private

- (void)createScene
{
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = NO;
    
    skView.ignoresSiblingOrder = YES;
    
    GameScene *scene = [GameScene sceneWithSize:self.view.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    scene.gameSceneDelegate = self;
    
    [skView presentScene:scene];
}

#pragma mark - GameScene Delegate

- (void)gameSceneProtocolGameOverAction
{
    [self createScene];
    [self showRatingView];
}

- (void)gameSceneProtocolGameStartAction
{
    if (self.constraintMenuOffset.constant == 0) {
        [self closeMenu];
    }
    [self setGameInfoHidden:YES];
    [self isGetReadyImageHidden:NO];
}

- (void)gameSceneProtocolBirdPhysicBodyAdd
{
    [self isGetReadyImageHidden:YES];
}

#pragma mark - SettingsView Delegate

- (void)settingsViewProtocolCloseAction
{
    if (self.settingsView.isSomethingChanged) {
        [self createScene];
        self.settingsView.isSomethingChanged = NO;
    }
    self.menuButton.hidden = NO;
    [self.settingsView removeFromSuperview];
    self.settingsView = nil;
}

#pragma mark - UI setup

- (BOOL)shouldAutorotate
{
    return YES;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
