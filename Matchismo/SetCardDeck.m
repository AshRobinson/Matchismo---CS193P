//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Ashley Robinson on 04/08/2013.
//  Copyright (c) 2013 Ashley Robinson. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

-(id)init
{
    self = [super init];
    
    if (self) {
        for (NSString *shadings in [SetCard validShadings]){
            for (NSString *colors in [SetCard validColors]){
                for (NSString *symbols in [SetCard validSymbols]){
                    for (NSUInteger i = 1; i <= [SetCard maxNumber]; i++){
                        SetCard *card = [[SetCard alloc] init];
                        card.shading = shadings;
                        card.color = colors;
                        card.symbol = symbols;
                        card.number = i;
                        [self addCard:card atTop:YES];
                    }
                }
            }
        }
        
    }
    return self;
}

@end
