//
//  Background.m
//  flappyBird
//
//  Created by ... on 03/19/16.
//  Copyright © 2016 ... All rights reserved.
//

#import "Background.h"

@implementation Background

- (id)initBackgroundWithImage:(NSString *)image width:(CGFloat)width andYPosition:(CGFloat)yPosition
{
    if (self = [super init]) {
        UIImage * img = [UIImage imageNamed:image];
        
        self = [Background spriteNodeWithColor:[UIColor clearColor] size:CGSizeMake(width, img.size.height)];
        
        CGFloat fullBackgroundSize = 0;
        for ( ; width + img.size.width > fullBackgroundSize; ) {
            SKSpriteNode * childImage = [SKSpriteNode spriteNodeWithImageNamed:image];
            
            childImage.anchorPoint = CGPointZero;
            childImage.position = CGPointMake(fullBackgroundSize, yPosition);
            
            [self addChild:childImage];
            
            fullBackgroundSize += childImage.size.width;
        }
    }
    
    return self;
}

- (void)update:(NSTimeInterval)currentTime
{
    for (SKSpriteNode *child in self.children) {
        child.position = CGPointMake(child.position.x - self.scrollSpeed, child.position.y);
        
        if (child.position.x <= -child.size.width) {
            child.position = CGPointMake(child.position.x + child.size.width * self.children.count, child.position.y);
        }
    }
}

@end
