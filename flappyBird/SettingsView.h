//
//  HeaderView.h
//  flappyBird
//
//  Created by ... 03/23/16.
//  Copyright © 2016 ... All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SettingsViewProtocol <NSObject>

- (void)settingsViewProtocolCloseAction;

@end

@interface SettingsView : UIView

@property (assign, nonatomic) BOOL isSomethingChanged;
@property (strong, nonatomic) id<SettingsViewProtocol> delegate;

@end
