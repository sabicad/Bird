//
//  LeaderBoardView.h
//  flappyBird
//
//  Created by ... 03/23/16.
//  Copyright © 2016 ... All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LeaderBoardViewProtocol <NSObject>

- (void)leaderBoardViewProtocolCloseAction;

@end

@interface LeaderBoardView : UIView <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) id<LeaderBoardViewProtocol> delegate;

@end
