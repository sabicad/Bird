//
//  AboutView.m
//  flappyBird
//
//  Created by ... 03/23/16.
//  Copyright © 2016 ... All rights reserved.
//

#import "AboutView.h"

@interface AboutView()

@property (weak, nonatomic) IBOutlet UIImageView *birdImage;

@end


@implementation AboutView

- (void)awakeFromNib
{
    self.birdImage.transform = CGAffineTransformScale(self.birdImage.transform, 1.3, 1.3);
}

- (IBAction)closeButtonAction:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(aboutViewProtocolCloseAction)]) {
        [self.delegate aboutViewProtocolCloseAction];
    }
}

@end
