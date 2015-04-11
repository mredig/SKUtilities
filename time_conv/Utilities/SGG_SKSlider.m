//
//  SGG_SKSlider.m
//  SGG_SKUtilities
//
//  Created by Michael Redig on 8/7/14.
//  Copyright (c) 2014 Michael Redig. All rights reserved.
//

#import "SGG_SKSlider.h"

@interface SGG_SKSlider () {
	
	SKSpriteNode* knob;
	SKSpriteNode* slide;
	
	bool knobDown;
	
	SKNode* offset;
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
	
	offset = [SKNode node];
	[self addChild:offset];
	
	
	knobDown = NO;
	_continuous = YES;
	_maxValue = 1.0;
	_minValue = 0.0;
	_sliderValue = 0.0;
	
	_knobTexture = [SKTexture textureWithImageNamed:@"sliderNob"];
	_knobTexturePressed = [SKTexture textureWithImageNamed:@"sliderNobPressed"];
	_sliderTexture = [SKTexture textureWithImageNamed:@"slider"];
	
	slide = [SKSpriteNode spriteNodeWithTexture:_sliderTexture];
	slide.anchorPoint = CGPointMake(0, 0.5);
	[offset addChild:slide];
	
	knob = [SKSpriteNode spriteNodeWithTexture:_knobTexture];
	
	[offset addChild:knob];
	
	self.anchorPoint = CGPointMake(0.5, 0.5);
	
}

-(void)setAnchorPoint:(CGPoint)anchorPoint {
	
	_anchorPoint = anchorPoint;
	
	CGFloat xPos, yPos;
	
	xPos = -slide.size.width * anchorPoint.x;
	
	yPos = -slide.size.height * anchorPoint.y + (slide.size.height * 0.5);
	
	offset.position = CGPointMake(xPos, yPos);
	
}


-(void)setKnobTexture:(SKTexture *)knobTexture {
	
	_knobTexture = knobTexture;
	if (!knobDown) {
		knob.texture = _knobTexture;
		knob.size = _knobTexture.size;
	}
	
}

-(void)setKnobTexturePressed:(SKTexture *)knobTexturePressed {
	_knobTexturePressed = knobTexturePressed;
	if (knobDown) {
		knob.texture = _knobTexturePressed;
		knob.size = _knobTexturePressed.size;
	}
}

-(void)setSliderTexture:(SKTexture *)sliderTexture {
	
	_sliderTexture = sliderTexture;
	
	slide.texture = _sliderTexture;
	slide.size = _sliderTexture.size;
	
	[self setAnchorPoint:_anchorPoint];
	[self setSliderValue:_sliderValue];

	
}

-(void)setSliderSize:(CGSize)sliderSize {
	
	_sliderSize = sliderSize;
	
	slide.size = _sliderSize;
	
	[self setAnchorPoint:_anchorPoint];
	[self setSliderValue:_sliderValue];
	
}



-(void)knobDown:(CGPoint)location {
	
	knob.texture = _knobTexturePressed;
	knob.size = _knobTexturePressed.size;
	knobDown = YES;
	
}

-(void)knobMoved:(CGPoint)location {
	
	CGPoint locAdjust = [self convertPoint:location toNode:offset];

	knob.position = CGPointMake(locAdjust.x, 0);
	if (knob.position.x < 0) {
		knob.position = CGPointMake(0, 0);
	}
	
	if (knob.position.x > slide.size.width) {
		knob.position = CGPointMake(slide.size.width, 0);
	}
	
	if (_continuous) {
		[self evaluateSliderValue];
	}
}

-(void)knobReleased:(CGPoint)location {

	knobDown = NO;
	knob.texture = _knobTexture;
	knob.size = _knobTexture.size;
	[self evaluateSliderValue];
	
}

-(void)evaluateSliderValue {
	
	CGFloat sliderPos = knob.position.x / slide.size.width;
	
	CGFloat extremesDifference = _maxValue - _minValue;
	
	_sliderValue = (sliderPos * extremesDifference) + _minValue;
	
	[_delegate sliderValueChanged:self];
	
//	NSLog(@"Slider: %f", _sliderValue);
	
}

-(void)setSliderValue:(CGFloat)sliderValue {
	
	_sliderValue = sliderValue;
	
	CGFloat extremesDifference = _maxValue - _minValue;

	CGFloat xVal = (_sliderValue - _minValue) / extremesDifference;
	xVal *= slide.size.width;
	
	knob.position = CGPointMake(xVal, 0);
//	NSLog(@"set to %f - width: %f", sliderValue, slide.size.width);
	
	
}


#if TARGET_OS_IPHONE

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	
	if (self.parent) { //only run if node has a parent (crashes when trying to get location without existing)
		for (UITouch* touch in touches) {
			CGPoint location = [touch locationInNode:self];
			[self knobDown:location];
		}
	}
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	
	if (self.parent) { //only run if node has a parent (crashes when trying to get location without existing)
		for (UITouch* touch in touches) {
			CGPoint location = [touch locationInNode:self];
			[self knobMoved:location];
		}
	}
	
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	
	if (self.parent) { //only run if node has a parent (crashes when trying to get location without existing)
		for (UITouch* touch in touches) {
			CGPoint location = [touch locationInNode:self];
			[self knobReleased:location];
		}
	}
}

#else
-(void)mouseDown:(NSEvent *)theEvent {
	
	if (self.parent) { //only run if node has a parent (crashes when trying to get location without existing)
		CGPoint location = [theEvent locationInNode:self];
		
		[self knobDown:location];
	}
}

-(void)mouseDragged:(NSEvent *)theEvent {
	if (self.parent) { //only run if node has a parent (crashes when trying to get location without existing)
		CGPoint location = [theEvent locationInNode:self];
		
		[self knobMoved:location];
	}
}

-(void)mouseUp:(NSEvent *)theEvent {
	if (self.parent) { //only run if node has a parent (crashes when trying to get location without existing)
		CGPoint location = [theEvent locationInNode:self];
		
		[self knobReleased:location];
	}
	
}


#endif


@end
