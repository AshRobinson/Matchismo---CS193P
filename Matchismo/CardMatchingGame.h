//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Ashley Robinson on 30/07/2013.
//  Copyright (c) 2013 Ashley Robinson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck;

- (void)flipCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

@property (readonly, nonatomic) int score;

@end
