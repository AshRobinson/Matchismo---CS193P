//
//  Card.m
//  Matchismo
//
//  Created by Ashley Robinson on 26/07/2013.
//  Copyright (c) 2013 Ashley Robinson. All rights reserved.
//

#import "Card.h"

@interface Card()
@property (strong, nonatomic) NSMutableArray *otherCards;
@end

@implementation Card

- (NSMutableArray *)otherCards
{
    if (_otherCards) {
        _otherCards = [[NSMutableArray alloc] init];
    }
    return _otherCards;
}


- (Card*)drawCard
{
    NSUInteger index = arc4random() % self.otherCards.count;
    Card *card = self.otherCards[index];
    return card;
}

- (void)addCard:(Card*)card atTop:(BOOL) atTop;
{
    if(card){
        if(atTop){
            [self.otherCards insertObject:card atIndex:0];
        } else {
            [self.otherCards addObject:card];
        }
    }
}

@end
