//
//  SGG_SKSlider.h
//  SGG_SKUtilities
//
//  Created by Michael Redig on 8/7/14.
//  Copyright (c) 2014 Michael Redig. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SGG_SKMasterButton.h"

@interface SGG_SKSlider : SKNode 

@property (nonatomic) CGFloat maxValue;
@property (nonatomic) CGFloat minValue;
@property (nonatomic) BOOL continuous;

@property (nonatomic) CGFloat sliderValue;

@property (nonatomic, strong) SKTexture* nobTexture;
@property (nonatomic, strong) SKTexture* nobTexturePressed;
@property (nonatomic, strong) SKTexture* sliderTexture;



@end
