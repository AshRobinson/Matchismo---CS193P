//
//  SetCard.h
//  Matchismo
//
//  Created by Ashley Robinson on 04/08/2013.
//  Copyright (c) 2013 Ashley Robinson. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card


@property (strong, nonatomic) NSString *color;
@property (strong, nonatomic) NSString *symbol;
@property (strong, nonatomic) NSString *shading;
@property (nonatomic) NSUInteger number;

+ (NSArray *)validColors;
+ (NSArray *)validSymbols;
+ (NSArray *)validShadings;
+ (NSUInteger)maxNumber;

@end
