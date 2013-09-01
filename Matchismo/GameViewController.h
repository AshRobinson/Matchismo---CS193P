//
//  GameViewController.h
//  Matchismo
//
//  Created by Ashley Robinson on 05/08/2013.
//  Copyright (c) 2013 Ashley Robinson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardMatchingGame.h"
#import "GameResult.h"
#import "GameSettings.h"

@interface GameViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *resultOfLastFlipLabel;

@property (strong, nonatomic) CardMatchingGame *game;

- (void)updateUI;

@property (nonatomic) BOOL removeUnplayableCards;

// abstract
- (Deck *)createDeck;

@property (nonatomic) NSUInteger startingCardCount;
@property (nonatomic) NSUInteger numberOfMatchingCards;
@property (strong, nonatomic) NSString *gameType;

- (void)updateCell:(UICollectionViewCell *)cell
         usingCard:(Card *)card;

@end
