//
//  RatingView.m
//  flappyBird
//
//  Created by ... on 03/21/15.
//  Copyright © 2016 ... All rights reserved.
//

#import "RatingView.h"
#import "GamerScore.h"
#import "CoreDataManager.h"

@interface RatingView()

@property (weak, nonatomic) IBOutlet UIImageView *medalImage;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *bestLabel;

@property (weak, nonatomic) IBOutlet UILabel *saveLabel;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (assign, nonatomic) NSInteger currentScore;

@end


@implementation RatingView

- (void)awakeFromNib
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];

    self.currentScore = [[NSUserDefaults standardUserDefaults] integerForKey:kValueCurrentScore];
    
    self.medalImage.image = nil;
    
    if (self.currentScore > 9 && self.currentScore < kMedalRatingBronzeMax) {
        self.medalImage.image = [UIImage imageNamed:@"bronze"];
    } else if (self.currentScore >= kMedalRatingBronzeMax && self.currentScore < kMedalRatingSilverMax) {
        self.medalImage.image = [UIImage imageNamed:@"silver"];
    } else if (self.currentScore >= kMedalRatingSilverMax && self.currentScore < kMedalRatingGoldMax) {
        self.medalImage.image = [UIImage imageNamed:@"gold"];
    } else if (self.currentScore >= kMedalRatingGoldMax  ) {
        self.medalImage.image = [UIImage imageNamed:@"platinum"];
    }
    
    GamerScore *maxScore = [CoreDataManager sharedManager].getMaximumScore;
    
    self.scoreLabel.text = [NSString stringWithFormat:@"%ld", (long)self.currentScore];
    self.bestLabel.text = maxScore ? [maxScore getScore] : @"-";
    
    [self deactivateSaveButton];
    
    [self setIsNeedToShowSaveView:self.currentScore > 0 ? 1 : 0];
    
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    CGRect newBounds = self.bounds;
    newBounds.origin.y = 0;
    self.bounds = newBounds;
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary* info = [notification userInfo];
    CGRect keyboardFrame = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat spaceFromKeyboard = self.frame.size.height - keyboardFrame.size.height;
    
    if (self.nameTextField.frame.origin.y > spaceFromKeyboard) {
        CGRect newBounds = self.bounds;
        newBounds.origin.y = self.nameTextField.frame.origin.y - spaceFromKeyboard - newBounds.origin.y + self.nameTextField.frame.size.height;
        self.bounds = newBounds;
    }
}

- (void)setIsNeedToShowSaveView:(BOOL)value
{
    self.nameTextField.alpha = value;
    self.saveButton.alpha = value;
    self.nameTextField.alpha = value;
    self.saveLabel.alpha = value;
}

- (IBAction)closeButtonAction:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(ratingViewProtocolCloseAction)]) {
        [self.delegate ratingViewProtocolCloseAction];
    }
}

- (IBAction)saveAction:(id)sender
{
    GamerScore *gamerScore = [[CoreDataManager sharedManager] objectWithEntityName:NSStringFromClass([GamerScore class])];
    gamerScore.name = self.nameTextField.text;
    gamerScore.score = [NSNumber numberWithInteger:self.currentScore];
    
    [[CoreDataManager sharedManager] saveContext];
    
    [self closeButtonAction:self];
}

#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField*)textField
{
    [self endEditing:YES];
    
    return YES;
}

- (IBAction)textFieldValueChanged:(id)sender
{
    if (self.nameTextField.text.length > 0) {
        [self activateSaveButton];
    } else{
        [self deactivateSaveButton];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    if ([touch view] != self.nameTextField) {
        [self.nameTextField resignFirstResponder];
    }
    
    [super touchesBegan:touches withEvent:event];
}

#pragma mark - Private

- (void)activateSaveButton
{
    self.saveButton.hidden = NO;
    self.saveButton.userInteractionEnabled = YES;
}

- (void)deactivateSaveButton
{
    self.saveButton.hidden = YES;
    self.saveButton.userInteractionEnabled = NO;
}

@end
