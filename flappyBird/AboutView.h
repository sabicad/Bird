//
//  AboutView.h
//  flappyBird
//
//  Created by ... 03/23/16.
//  Copyright © 2016 ... All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AboutViewProtocol <NSObject>

- (void)aboutViewProtocolCloseAction;

@end

@interface AboutView : UIView

@property (strong, nonatomic) id<AboutViewProtocol> delegate;

@end
