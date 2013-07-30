//
//  PlayingCard.h
//  Matchismo
//
//  Created by Ashley Robinson on 27/07/2013.
//  Copyright (c) 2013 Ashley Robinson. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
