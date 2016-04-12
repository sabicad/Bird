//
//  MenuView.h
//  flappyBird
//
//  Created by ... 03/23/16.
//  Copyright © 2016 ... All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuViewProtocol <NSObject>

- (void)menuViewProtocolSettingsAction;
- (void)menuViewProtocolAboutAction;
- (void)menuViewProtocolLeaderboardAction;

@end

@interface MenuView : UIView

@property (strong, nonatomic) id<MenuViewProtocol> delegate;

@end
