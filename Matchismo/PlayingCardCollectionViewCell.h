//
//  PlayingCardCollectionViewCell.h
//  Matchismo
//
//  Created by Ashley Robinson on 14/08/2013.
//  Copyright (c) 2013 Ashley Robinson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayingCardView.h"

@interface PlayingCardCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet PlayingCardView *playingCardView;

@end
