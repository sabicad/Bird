//
//  RatingView.h
//  flappyBird
//
//  Created by ... 03/23/16.
//  Copyright © 2016 ... All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RatingViewProtocol <NSObject>

- (void)ratingViewProtocolCloseAction;

@end

@interface RatingView : UIView<UITextFieldDelegate>

@property (strong, nonatomic) id<RatingViewProtocol> delegate;

@end
