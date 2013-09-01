//
//  SetCardView.h
//  Matchismo
//
//  Created by Ashley Robinson on 21/08/2013.
//  Copyright (c) 2013 Ashley Robinson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetCardView : UIView

@property (strong, nonatomic) NSString *color;
@property (strong, nonatomic) NSString *symbol;
@property (strong, nonatomic) NSString *shading;
@property (nonatomic) NSUInteger number;

@property (nonatomic) BOOL faceUp;


@end
