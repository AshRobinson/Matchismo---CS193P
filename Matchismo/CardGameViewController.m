//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Ashley Robinson on 26/07/2013.
//  Copyright (c) 2013 Ashley Robinson. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UISlider *messageSlider;
@property (weak, nonatomic) IBOutlet UISegmentedControl *matchModeSegmentedControl;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) CardMatchingGame *game;
@end

// Class implementation
@implementation CardGameViewController
// Returns a fully initiaized game instance.
- (CardMatchingGame *)game {
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                  usingDeck:[[PlayingCardDeck alloc] init]
                                                 matchCount:(self.matchModeSegmentedControl.selectedSegmentIndex + 2)];
    }
    
    return _game;
}

// Sets the game card buttons.
- (void)setCardButtons:(NSArray *)cardButtons {
    _cardButtons = cardButtons;
    [self updateUI];
}

// Renders the complete user interface.
- (void)updateUI {
    // Update the card buttons
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = (card.isUnplayable) ? 0.3f : 1.0f;
        [cardButton setBackgroundImage:(cardButton.selected) ? [UIImage imageNamed:@"cardfront2.png"] : [UIImage imageNamed:@"cardback2.png"] forState:UIControlStateNormal];
    }
    
    // Updates the score label
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    
    // Display the last game message and update the message slider accordingly
    [self displayMessage:0];
    self.messageSlider.minimumValue = (self.game.messageCount > 0) ? (float)(self.game.messageCount - 1) * -1.0f : 0.0f;
    [self.messageSlider setValue:self.messageSlider.maximumValue animated:!(self.messageSlider.value == self.messageSlider.maximumValue)];
    
    // Toggle the match mode control based on whether a game has already been started
    self.matchModeSegmentedControl.enabled = !(self.flipCount > 0);
}

// Sets the flips count label.
- (void)setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

// Flips a game card.
- (IBAction)flipCard:(UIButton *)sender {
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}

// Shows a game message string.
- (void)displayMessage:(NSUInteger)index {
    self.messageLabel.text = (self.game.messageCount > 0) ? [self.game messageAtIndex:index] : @"Flip a card!";
    self.messageLabel.alpha = (index == 0) ? 1.0f : 0.5f;
}

// Updates the game message to display based on the position of the message slider.
- (IBAction)scrubMessages:(id)sender {
    UISlider *slider = (UISlider *)sender;
    float stepValue = floorf(slider.value + 0.5f);
    self.messageSlider.value = stepValue;
    [self displayMessage:(int)(stepValue * -1.0f)];
}

// Resets the game.
- (IBAction)dealButton {
    self.game = nil;
    self.flipCount = 0;
    [self updateUI];
}

// Sets the game's match mode based on the selected segment's selected index.
- (IBAction)changeMatchMode:(UISegmentedControl *)sender {
    [self.game setMatchCount:(sender.selectedSegmentIndex + 2)];
}

@end