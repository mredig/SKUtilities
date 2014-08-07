//
//  SGG_SKSlider.m
//  SGG_SKUtilities
//
//  Created by Michael Redig on 8/7/14.
//  Copyright (c) 2014 Michael Redig. All rights reserved.
//

#import "SGG_SKSlider.h"

@interface SGG_SKSlider () {
	
	SKSpriteNode* nob;
	SKSpriteNode* slide;
	
	
}

@end

@implementation SGG_SKSlider

-(id)init {
	
	if (self = [super init]) {
		[self setupSlider];
	}
	return self;
}

-(void)setupSlider {
	
	self.userInteractionEnabled = YES;
	
	
	_nobTexture = [SKTexture textureWithImageNamed:@"sliderNob"];
	_nobTexturePressed = [SKTexture textureWithImageNamed:@"sliderNobPressed"];
	_sliderTexture = [SKTexture textureWithImageNamed:@"slider"];
	
	slide = [SKSpriteNode spriteNodeWithTexture:_sliderTexture];
	slide.anchorPoint = CGPointMake(0, 0.5);
	[self addChild:slide];
	
	nob = [SKSpriteNode spriteNodeWithTexture:_nobTexture];
	
	[self addChild:nob];
	
}


-(void)nobDown:(CGPoint)location {
	
	nob.texture = _nobTexturePressed;
	
}

-(void)nobMoved:(CGPoint)location {

	nob.position = CGPointMake(location.x, 0);
	if (nob.position.x < 0) {
		nob.position = CGPointMake(0, 0);
	}
	
	if (nob.position.x > slide.size.width) {
		nob.position = CGPointMake(slide.size.width, 0);
	}
	
	if (_continuous) {
		[self evaluateSliderValue];
	}
}

-(void)nobReleased:(CGPoint)location {

	nob.texture = _nobTexture;
	[self evaluateSliderValue];
	
}

-(void)evaluateSliderValue {
	
	CGFloat sliderPos = nob.position.x / slide.size.width;
	
	CGFloat extremesDifference = _maxValue - _minValue;
	
	_sliderValue = (sliderPos * extremesDifference) + _minValue;
	
	
//	NSLog(@"Slider: %f", _sliderValue);
	
}


#if TARGET_OS_IPHONE

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	
	[self buttonPressed];
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	
	for (UITouch* touch in touches) {
		CGPoint location = [touch locationInNode:self];
		[self buttonReleased:location];
	}
}

#else
-(void)mouseDown:(NSEvent *)theEvent {
	
	if (self.parent) { //only run if node has a parent (crashes when trying to get location without existing)
		CGPoint location = [theEvent locationInNode:self];
		
		[self nobDown:location];
	}
}

-(void)mouseDragged:(NSEvent *)theEvent {
	if (self.parent) { //only run if node has a parent (crashes when trying to get location without existing)
		CGPoint location = [theEvent locationInNode:self];
		
		[self nobMoved:location];
	}
}

-(void)mouseUp:(NSEvent *)theEvent {
	if (self.parent) { //only run if node has a parent (crashes when trying to get location without existing)
		CGPoint location = [theEvent locationInNode:self];
		
		[self nobReleased:location];
	}
	
}


#endif


@end
