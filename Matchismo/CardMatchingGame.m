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
@property (readwrite, nonatomic) int score;
@property (readwrite, nonatomic) NSString *descriptionOfLastFlip;

@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        for (int i = 0; i < cardCount; i++){
            Card *card = [deck drawRandomCard];
            if (!card){
                self = nil;
            } else {
                self.cards[i] = card;
            }
        }
    }
                          
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < self.cards.count ? self.cards[index] : nil);
}



#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

- (void) flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if (!card.isUnplayable){
        if (!card.isFaceUp) {
            self.descriptionOfLastFlip = [NSString stringWithFormat:@"Flipped up %@.", card.contents];
            for(Card *otherCard in self.cards){
                if (otherCard.isFaceUp && !otherCard.isUnplayable){
                    int matchScore = [card match:@[otherCard]];
                    if(matchScore){
                        self.descriptionOfLastFlip = [NSString stringWithFormat:@"Matched %@ with %@ for a score of %d points.", card.contents, otherCard.contents, matchScore * MATCH_BONUS];
                        otherCard.unplayable = YES;
                        card.unplayable = YES;
                        self.score += matchScore * MATCH_BONUS;
                    } else {
                         self.descriptionOfLastFlip = [NSString stringWithFormat:@"%@ and %@ don't match, %d point penalty!", card.contents, otherCard.contents, matchScore -+ MISMATCH_PENALTY];
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                    }
                    break;
                }
            }
            self.score -= FLIP_COST;
        }
        card.faceUp = !card.isFaceUp;
    }
}

@end
