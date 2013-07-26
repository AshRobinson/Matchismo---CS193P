//
//  Card.h
//  Matchismo
//
//  Created by Ashley Robinson on 26/07/2013.
//  Copyright (c) 2013 Ashley Robinson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

- (Card*)drawCard;
- (void)addCard:(Card*)card atTop:(BOOL) atTop;

@end
