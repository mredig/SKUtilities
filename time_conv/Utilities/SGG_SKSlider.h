//
//  SGG_SKSlider.h
//  SGG_SKUtilities
//
//  Created by Michael Redig on 8/7/14.
//  Copyright (c) 2014 Michael Redig. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SGG_SKMasterButton.h"

@class SGG_SKSlider;
@protocol SGG_SKSliderDelegate   //define delegate protocol

-(void)sliderValueChanged:(SGG_SKSlider*)slider;

@end

@interface SGG_SKSlider : SKNode 



@property (nonatomic) CGFloat maxValue; //default 1.0
@property (nonatomic) CGFloat minValue; //default 0.0
@property (nonatomic) BOOL continuous; //defaults to YES

@property (nonatomic) CGFloat sliderValue; //default 0.0
@property (nonatomic) NSInteger sliderID;
@property (nonatomic) CGSize sliderSize;



@property (nonatomic, strong) SKTexture* nobTexture;
@property (nonatomic, strong) SKTexture* nobTexturePressed;
@property (nonatomic, strong) SKTexture* sliderTexture;

@property (nonatomic, weak) id <SGG_SKSliderDelegate> delegate; //define MyClassDelegate as delegate

@end
