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
	
	bool nobDown;
	
	
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
	
	nobDown = NO;
	_continuous = YES;
	_maxValue = 1.0;
	_minValue = 0.0;
	_sliderValue = 0.0;
	
	_nobTexture = [SKTexture textureWithImageNamed:@"sliderNob"];
	_nobTexturePressed = [SKTexture textureWithImageNamed:@"sliderNobPressed"];
	_sliderTexture = [SKTexture textureWithImageNamed:@"slider"];
	
	slide = [SKSpriteNode spriteNodeWithTexture:_sliderTexture];
	slide.anchorPoint = CGPointMake(0, 0.5);
	[self addChild:slide];
	
	nob = [SKSpriteNode spriteNodeWithTexture:_nobTexture];
	
	[self addChild:nob];
	
}

-(void)setNobTexture:(SKTexture *)nobTexture {
	
	_nobTexture = nobTexture;
	if (!nobDown) {
		nob.texture = _nobTexture;
		nob.size = _nobTexture.size;
	}
	
}

-(void)setNobTexturePressed:(SKTexture *)nobTexturePressed {
	_nobTexturePressed = nobTexturePressed;
	if (nobDown) {
		nob.texture = _nobTexturePressed;
		nob.size = _nobTexturePressed.size;
	}
}

-(void)setSliderTexture:(SKTexture *)sliderTexture {
	
	_sliderTexture = sliderTexture;
	
	slide.texture = _sliderTexture;
	slide.size = _sliderTexture.size;
	
}



-(void)nobDown:(CGPoint)location {
	
	nob.texture = _nobTexturePressed;
	nob.size = _nobTexturePressed.size;
	nobDown = YES;
	
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

	nobDown = NO;
	nob.texture = _nobTexture;
	nob.size = _nobTexture.size;
	[self evaluateSliderValue];
	
}

-(void)evaluateSliderValue {
	
	CGFloat sliderPos = nob.position.x / slide.size.width;
	
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
	
	nob.position = CGPointMake(xVal, 0);
	
	
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
