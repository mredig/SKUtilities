//
//  SGG_SKButton.m
//
//  Created by Michael Redig on 2/8/14.
//  Copyright (c) 2014 Michael Redig. All rights reserved.
//

#import "SGG_SKButton.h"


@interface SGG_SKButton () {

}

@end

@implementation SGG_SKButton


#pragma mark INIT and STUFF
-(id) init {
	if (self = [super init]) {
		// do initialization here
		[self setUpStandardValues];
		//		_debugMode = YES;
	}
	return self;
}

-(void)setUpStandardValues {
	
	_buttonDictionary = [[NSMutableDictionary alloc] init];
	
	_isEnabled = YES;
	self.userInteractionEnabled = YES;
	self.name = @"SKButton";
	
	_anchorPoint = CGPointMake(0.5, 0.5);
	
	_anchorMover = [SKNode node];
	[self addChild:_anchorMover];
	_anchorMover.name = @"anchorMover";
}


#pragma mark BUTTON SETUPS


#pragma mark BUTTON COMPONENTS

-(void)setUpBase {
	
	//check if there's a base texture and apply for both neutral and pressed states
	if (_textureBase) {
		_baseButton = [SKSpriteNode spriteNodeWithTexture:_textureBase];
		_baseButton.name = @"baseButtonSprite";
		[_anchorMover addChild:_baseButton];
	} else {
		if (_debugMode) {
			NSLog(@"Warning: Button setup requires a base texture to properly function. Enumerator: %i Button: %@", _whichButton, self);
		}
	}
	
	if (_textureBasePressed) {
		_baseButtonPressed = [SKSpriteNode spriteNodeWithTexture:_textureBasePressed];
		[_anchorMover addChild:_baseButtonPressed];
	} else {
		_baseButtonPressed = [SKSpriteNode spriteNodeWithTexture:_textureBase]; //this may be a point of error if you can't apply the same tex to two sprites
		[_anchorMover addChild:_baseButtonPressed];
	}
	_baseButtonPressed.name = @"baseButtonPressedSprite";
	_baseButtonPressed.hidden = HIDDEN;
	
	
	if (_textureDisabled) {
		_baseButtonDisabled = [SKSpriteNode spriteNodeWithTexture:_textureDisabled];
		[_anchorMover addChild:_baseButtonDisabled];
	} else {
		if (_disableType == kButtonDisableTypeAlternateTexture) {
			_disableType = kButtonDisableTypeDim;
		}
	}
	_baseButtonDisabled.name = @"baseButtonDisabledSprite";
	_baseButtonDisabled.hidden = HIDDEN;
}


-(void)setButtonSize { //requires baseButton sprite to be set
	
	SKColor* bgColor;
	if (_debugMode) {
		bgColor = [SKColor grayColor];
	} else {
		bgColor = [SKColor clearColor];
	}
	if (_touchAreaSize.width == 0 || _touchAreaSize.height == 0) {
		_touchAreaSize = _baseButton.frame.size;
	}
	
	_buttonBounds = [SKSpriteNode spriteNodeWithColor:bgColor size:_touchAreaSize];
	_buttonBounds.name = @"buttonBounds";
	[_anchorMover addChild:_buttonBounds];
	_buttonBounds.zPosition = -1;
}

-(void)setUpAnchor {
	
	CGRect totalRect = [self calculateAccumulatedFrame];
	CGSize totalSize = totalRect.size;
	
	CGPoint adjustedAnchorPoint = CGPointMake(_anchorPoint.x - 0.5, _anchorPoint.y - 0.5);
	
	_anchorMover.position = CGPointMake(-adjustedAnchorPoint.x * totalSize.width, -adjustedAnchorPoint.y * totalSize.height);
	
}

#pragma mark BUTTON METHODS



-(void)enableButton {
	
	_isEnabled = YES;

	[_anchorMover enumerateChildNodesWithName:@"*" usingBlock:^(SKNode *node, BOOL *stop) {
		if (![node.name isEqualToString:@"buttonBounds"]) {
			SKSpriteNode* image = (SKSpriteNode*)node;
			image.colorBlendFactor = 0;
		}
	}];
	self.hidden = VISIBLE;
	self.alpha = 1;
	_baseButton.hidden = VISIBLE;
	_baseButtonDisabled.hidden = HIDDEN;
	
}

-(void)disableButton {
	
	[self enableButton]; //reset
	_isEnabled = NO;
	if (_disableType == kButtonDisableTypeOpacityHalf) {
		self.alpha = 0.5;
	} else if (_disableType == kButtonDisableTypeOpacityNone) {
		self.hidden = HIDDEN;
	} else if (_disableType == kButtonDisableTypeDim) {
		SKColor* dimColor = [SKColor grayColor];
		[_anchorMover enumerateChildNodesWithName:@"*" usingBlock:^(SKNode *node, BOOL *stop) {
			if (![node.name isEqualToString:@"buttonBounds"]) {
				SKSpriteNode* sprite = (SKSpriteNode*) node;
				sprite.color = dimColor;
				sprite.colorBlendFactor = 0.5;
			}
		}];
	} else if (_disableType == kButtonDisableTypeAlternateTexture) {
		_baseButton.hidden = HIDDEN;
		_baseButtonPressed.hidden = HIDDEN;
		_baseButtonDisabled.hidden = VISIBLE;
	} else if (_disableType == kButtonDisableTypeNoDifference) {
		//don't change anything other than boolean
	}
	
//	[self enumerateChildNodesWithName:@"//*" usingBlock:^(SKNode *node, BOOL *stop) {
//		NSLog(@"%@ is hidden: %i", node.name, node.hidden);
//	}];
}


-(void)buttonPressed {
	
	if (_isEnabled) {

	}
	
	NSLog(@"super triggered");
}

-(void)buttonReleased:(CGPoint)location {
	
	if (_isEnabled) {

	}
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
	
	[self buttonPressed];
	
}

-(void)mouseUp:(NSEvent *)theEvent {
	if (self.parent) { //only run if node has a parent (crashes when trying to get location without existing)
		CGPoint location = [theEvent locationInNode:self];
		
		[self buttonReleased:location];
	}

}


#endif
@end
