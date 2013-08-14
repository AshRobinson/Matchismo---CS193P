//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Ashley Robinson on 30/07/2013.
//  Copyright (c) 2013 Ashley Robinson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject


@property (readonly, nonatomic) int score;
@property (readonly, nonatomic) NSString *descriptionOfLastFlip;

@property (nonatomic) int numberOfMatchingCards;

@property (nonatomic) int matchBonus;
@property (nonatomic) int mismatchPenalty;
@property (nonatomic) int flipCost;

@property (nonatomic) int numberOfCards;

// designated initializer
- (id)initWithCardCount:(NSUInteger)count
              usingDeck:(Deck *)deck;

- (Card *)cardAtIndex:(NSUInteger)index;
- (void)flipCardAtIndex:(NSUInteger)index;


@end
