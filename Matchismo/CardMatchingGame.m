//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Ashley Robinson on 30/07/2013.
//  Copyright (c) 2013 Ashley Robinson. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame ()

@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic, readwrite) int score;
@property (strong, nonatomic) NSMutableArray *messages;

@end

// Class implementation
@implementation CardMatchingGame
// Constants
#define FLIP_COST 1
#define MISMATCH_PENALTY 2
#define MATCH_BONUS 4
#define MAX_MESSAGES 50
#define MIN_MATCH_COUNT 2
#define MAX_MATCH_COUNT 3

// Designated initializer
- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck matchCount:(NSUInteger)matchCount {
    self = [super init];
    if (self) {
        for (int i = 0; i < cardCount; i++) {
            Card *card = [deck drawRandomCard];
            if (!card) {
                self = nil;
            } else {
                self.cards[i] = card;
            }
        }
        self.matchCount = matchCount;
    }
    
    return self;
}

// Returns the collection of game cards.
- (NSMutableArray *)cards {
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    
    return _cards;
}

// Returns the collection of play messages.
- (NSMutableArray *)messages {
    if (!_messages) {
        _messages = [[NSMutableArray alloc] init];
    }
    
    return _messages;
}

// Custom synthesis
@synthesize matchCount  = _matchCount;

// Returns the number of game card matches to use.
- (NSUInteger)matchCount {
    if (!_matchCount) {
        _matchCount = MIN_MATCH_COUNT;
    }
    
    return _matchCount;
}

// Sets the number of game card matches to use.
- (void)setMatchCount:(NSUInteger)matchCount {
    _matchCount = (matchCount < MIN_MATCH_COUNT) ? MIN_MATCH_COUNT : (matchCount > MAX_MATCH_COUNT) ? MAX_MATCH_COUNT : matchCount;
}

// Flip a card, compute a score, and record a play message.
- (void)flipCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    if (!card.isUnplayable) {
        if (!card.isFaceUp) {
            // Collect the cards to match
            NSMutableString *cardsString = nil;
            NSMutableArray *cardsToMatch = nil;
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    // Include the card we're flipping in the collection of cards to match
                    if (!cardsToMatch) {
                        cardsToMatch = [[NSMutableArray alloc] init];
                        [cardsToMatch addObject:card];
                        cardsString = [NSMutableString stringWithFormat: @"%@", card.contents];
                    }
                    
                    [cardsToMatch addObject:otherCard];
                    [cardsString appendFormat:@" %@", otherCard.contents];
                    
                    // Stop collecting when we have the necessary number of cards to match
                    if (cardsToMatch.count == self.matchCount) {
                        break;
                    }
                }
            }
            
            // Check whether we have all the necessary cards
            NSString *message = nil;
            if (cardsToMatch.count == self.matchCount) {
                // Compute the total match score based on the cummulative score of matching pairs
                int matchScore = 0;
                for (int i = 0; i < cardsToMatch.count; i++) {
                    NSRange range;
                    range.location = i + 1;
                    range.length = cardsToMatch.count - (i + 1);
                    matchScore += [[cardsToMatch objectAtIndex:i] match:[cardsToMatch subarrayWithRange:range]];
                }
                
                // Check whether there were any matches
                if (matchScore) {
                    // Cards can only be used once if they are part of a group with at least a partial match
                    for (Card *otherCard in cardsToMatch) {
                        otherCard.unplayable = YES;
                    }
                    
                    // Compute the match points and add them to the current score
                    int points = matchScore * MATCH_BONUS;
                    self.score += points;
                    
                    message = [NSString stringWithFormat:@"Match found in %@ (+%d pts)", cardsString, points];
                    
                } else {
                    // Turn down all cards if there were no matches
                    for (Card *otherCard in cardsToMatch) {
                        otherCard.faceUp = NO;
                    }
                    
                    // Update the current score with the necessary penalty
                    self.score -= MISMATCH_PENALTY;
                    
                    message = [NSString stringWithFormat:@"No match found in %@ (-%d pts)", cardsString, MISMATCH_PENALTY];
                }
            }
            
            // Update the current score with the cost of flipping the card too
            self.score -= FLIP_COST;
            
            // Record a play message
            if (!message) {
                message = [NSString stringWithFormat:@"Flipped up %@", card.contents];
            }
            [self addMessage: message];
        }
        
        // Flip the card
        card.faceUp = !card.isFaceUp;
    }
}

// Returns a specific game card.
- (Card *)cardAtIndex:(NSUInteger)index {
    return (index < self.cards.count) ? self.cards[index] : nil;
}

// Returns the number of recorded play messages.
- (NSUInteger)messageCount {
    return self.messages.count;
}

// Returns a specific play message.
- (NSString *)messageAtIndex:(NSUInteger)index {
    return (index < self.messages.count) ? self.messages[index] : @"";
}

// Adds a message to the collection of play messages.
- (void)addMessage:(NSString *)message {
    if (message) {
        if (self.messages.count == MAX_MESSAGES) {
            [self.messages removeLastObject];
        }
        [self.messages insertObject:message atIndex:0];
    }
}

@end
