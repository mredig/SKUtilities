//
//  SGG_SKToggleButton.m
//
//  Created by Michael Redig on 2/8/14.
//  Copyright (c) 2014 Michael Redig. All rights reserved.
//

#import "SGG_SKToggleButton.h"

@interface SGG_SKToggleButton () {
	
	SKSpriteNode* buttonTitleOnToggledPress;
	SKSpriteNode* buttonTitleOnToggledDisabled;
	SKSpriteNode* buttonTitleOnToggled;
	SKSpriteNode* buttonTitleOffToggledPress;
	SKSpriteNode* buttonTitleOffToggledDisabled;
	SKSpriteNode* buttonTitleOffToggled;
	
}

@end


@implementation SGG_SKToggleButton

@synthesize delegate;


#pragma mark INIT and STUFF
-(id) init {
	if (self = [super init]) {
		// do initialization here
	}
	return self;
}

#pragma mark BUTTON SETUPS


-(void)setUpToggleButton {
	_buttonType = kIsToggleButton;
	
	[super setUpBase];
	
	[self setUpToggleStates];
	
	[super setButtonSize];
	
	[super setUpAnchor];
	
}


#pragma mark BUTTON COMPONENTS




-(void)setUpToggleStates {
	
	BOOL toggleOnIsSet;
	BOOL toggleOffIsSet;
	//check if there are labels and apply for both neutral and pressed states
	
	//enabled label
	if (_labelToggledOn) {
		_labelToggledOn.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
		_labelToggledOn.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
		[self.anchorMover addChild:_labelToggledOn];
		toggleOnIsSet = YES;
	}
	
	if (_labelToggledOnPressed) {
		_labelToggledOnPressed.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
		_labelToggledOnPressed.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
		[self.anchorMover addChild:_labelToggledOnPressed];
	} else if (!_labelToggledOnPressed && _labelToggledOn) { //if the press hasn't been inited, but the neutral has
		_labelToggledOnPressed = [SKLabelNode labelNodeWithFontNamed:_labelToggledOn.fontName];
		_labelToggledOnPressed.fontColor = _labelToggledOn.fontColor;
		_labelToggledOnPressed.fontSize = _labelToggledOn.fontSize;
		_labelToggledOnPressed.text = _labelToggledOn.text;
		_labelToggledOnPressed.blendMode = _labelToggledOn.blendMode;
		_labelToggledOnPressed.color = _labelToggledOn.color;
		_labelToggledOnPressed.colorBlendFactor = _labelToggledOn.colorBlendFactor;
		_labelToggledOnPressed.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
		_labelToggledOnPressed.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
		[self.anchorMover addChild:_labelToggledOnPressed];
	}
	_labelToggledOnPressed.hidden = HIDDEN;
	
	if (_labelToggledOnDisabled) {
		_labelToggledOnDisabled.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
		_labelToggledOnDisabled.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
		[self.anchorMover addChild:_labelToggledOnDisabled];
	}
	_labelToggledOnDisabled.hidden = HIDDEN;
	
	
	//disabled label
	if (_labelToggledOff) {
		_labelToggledOff.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
		_labelToggledOff.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
		[self.anchorMover addChild:_labelToggledOff];
		toggleOffIsSet = YES;
	}
	
	if (_labelToggledOffPressed) {
		_labelToggledOffPressed.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
		_labelToggledOffPressed.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
		[self.anchorMover addChild:_labelToggledOffPressed];
	} else if (!_labelToggledOffPressed && _labelToggledOff) { //if the press hasn't been inited, but the neutral has
		_labelToggledOffPressed = [SKLabelNode labelNodeWithFontNamed:_labelToggledOff.fontName];
		_labelToggledOffPressed.fontColor = _labelToggledOff.fontColor;
		_labelToggledOffPressed.fontSize = _labelToggledOff.fontSize;
		_labelToggledOffPressed.text = _labelToggledOff.text;
		_labelToggledOffPressed.blendMode = _labelToggledOff.blendMode;
		_labelToggledOffPressed.color = _labelToggledOff.color;
		_labelToggledOffPressed.colorBlendFactor = _labelToggledOff.colorBlendFactor;
		_labelToggledOffPressed.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
		_labelToggledOffPressed.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
		[self.anchorMover addChild:_labelToggledOffPressed];
	}
	_labelToggledOffPressed.hidden = HIDDEN;
	
	if (_labelToggledOffDisabled) {
		_labelToggledOffDisabled.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
		_labelToggledOffDisabled.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
		[self.anchorMover addChild:_labelToggledOffDisabled];
	}
	_labelToggledOffDisabled.hidden = HIDDEN;
	
	
	//check if there are textures and apply for both neutral and pressed states (note, both texture and label can appear at the same time... careful)
	//enabled Textures
	if (_textureToggledOn) {
		buttonTitleOnToggled = [SKSpriteNode spriteNodeWithTexture:_textureToggledOn];
		[self.anchorMover addChild:buttonTitleOnToggled];
		toggleOnIsSet = YES;
	}
	
	if (_textureToggledOnDisabled) {
		buttonTitleOnToggledDisabled = [SKSpriteNode spriteNodeWithTexture:_textureToggledOnDisabled];
		[self.anchorMover addChild:buttonTitleOnToggledDisabled];
	}
	buttonTitleOnToggledDisabled.hidden = HIDDEN;
	
	if (_textureToggledOnPressed) {
		buttonTitleOnToggledPress = [SKSpriteNode spriteNodeWithTexture:_textureToggledOnPressed];
		[self.anchorMover addChild:buttonTitleOnToggledPress];
	} else if (!_textureToggledOnPressed && _textureToggledOn) {
		buttonTitleOnToggledPress = [SKSpriteNode spriteNodeWithTexture:_textureToggledOn];
		[self.anchorMover addChild:buttonTitleOnToggledPress];
	}
	buttonTitleOnToggledPress.hidden = HIDDEN;
	
	//disabled Textures
	if (_textureToggledOff) {
		buttonTitleOffToggled = [SKSpriteNode spriteNodeWithTexture:_textureToggledOff];
		[self.anchorMover addChild:buttonTitleOffToggled];
		toggleOnIsSet = YES;
	}
	
	if (_textureToggledOffDisabled) {
		buttonTitleOffToggledDisabled = [SKSpriteNode spriteNodeWithTexture:_textureToggledOffDisabled];
		[self.anchorMover addChild:buttonTitleOffToggledDisabled];
	}
	buttonTitleOffToggledDisabled.hidden = HIDDEN;
	
	if (_textureToggledOffPressed) {
		buttonTitleOffToggledPress = [SKSpriteNode spriteNodeWithTexture:_textureToggledOffPressed];
		[self.anchorMover addChild:buttonTitleOffToggledPress];
	} else if (!_textureToggledOffPressed && _textureToggledOff) {
		buttonTitleOffToggledPress = [SKSpriteNode spriteNodeWithTexture:_textureToggledOff];
		[self.anchorMover addChild:buttonTitleOffToggledPress];
	}
	buttonTitleOffToggledPress.hidden = HIDDEN;
	
	
	//check default state and set hidden accordingly
	
	
	if (_defaultState) {
		_labelToggledOn.hidden = VISIBLE;
		buttonTitleOnToggled.hidden = VISIBLE;
		_labelToggledOff.hidden = HIDDEN;
		buttonTitleOffToggled.hidden = HIDDEN;
		_on = YES;
	} else {
		_labelToggledOn.hidden = HIDDEN;
		buttonTitleOnToggled.hidden = HIDDEN;
		_labelToggledOff.hidden = VISIBLE;
		buttonTitleOffToggled.hidden = VISIBLE;
		_on = NO;
	}
	
	if (!toggleOnIsSet || !toggleOffIsSet) {
		if (self.debugMode) {
			NSLog(@"Warning: Toggle button setup requires enable and disable states (labels or textures) to properly function. Enumerator: %i Button: %@", self.whichButton, self);
		}
	}
}




#pragma mark BUTTON METHODS


-(void)enableButton {
	[super enableButton];
	buttonTitleOffToggledDisabled.hidden = HIDDEN;
	buttonTitleOnToggledDisabled.hidden = HIDDEN;
	if (_on) {
		buttonTitleOnToggled.hidden = VISIBLE;
		buttonTitleOffToggled.hidden = HIDDEN;
	} else {
		buttonTitleOnToggled.hidden = HIDDEN;
		buttonTitleOffToggled.hidden = VISIBLE;
	}
}

-(void)disableButton {
	[super disableButton];
	
	if (self.disableType == kButtonDisableTypeAlternateTexture) {

		buttonTitleOnToggled.hidden = HIDDEN;
		buttonTitleOffToggled.hidden = HIDDEN;

		if (_on) {
			buttonTitleOffToggledDisabled.hidden = HIDDEN;
			buttonTitleOnToggledDisabled.hidden = VISIBLE;
		} else {
			buttonTitleOffToggledDisabled.hidden = VISIBLE;
			buttonTitleOnToggledDisabled.hidden =HIDDEN;
		}
	}
}




-(void)toggleButtonState {
	
	if (_on) {
		_on = NO;
	} else {
		_on = YES;
	}
	[self updateToggleTextures];
}

-(void)toggleButtonOn {
	_on = YES;
	[self updateToggleTextures];
}

-(void)toggleButtonOff {
	_on = NO;
	[self updateToggleTextures];
}

-(void)updateToggleTextures {
	
	if (_buttonType == kIsToggleButton) {
		if (_on) {
			_labelToggledOn.hidden = VISIBLE;
			buttonTitleOnToggled.hidden = VISIBLE;
			_labelToggledOff.hidden = HIDDEN;
			buttonTitleOffToggled.hidden = HIDDEN;
		} else {
			_labelToggledOn.hidden = HIDDEN;
			buttonTitleOnToggled.hidden = HIDDEN;
			_labelToggledOff.hidden = VISIBLE;
			buttonTitleOffToggled.hidden = VISIBLE;
		}
		if (!self.isEnabled) {
			[self disableButton];
		}
	}
}






-(void)buttonPressed {
	
	if (self.isEnabled) {
		//do button execution
//		SGG_MethodExecutor* executor = (SGG_MethodExecutor*) self.methodExecutor;
//		[executor doButtonDown:self];
		
		[self.delegate doButtonDown:self];
		
		//update button visual
		self.baseButton.hidden = HIDDEN;
		self.baseButtonPressed.hidden = VISIBLE;
		if (_buttonType == kIsToggleButton) {
			
			buttonTitleOnToggled.hidden = HIDDEN;
			buttonTitleOffToggled.hidden = HIDDEN;
			_labelToggledOn.hidden = HIDDEN;
			_labelToggledOff.hidden = HIDDEN;
			
			if (_on) {
				buttonTitleOnToggledPress.hidden = VISIBLE;
				_labelToggledOnPressed.hidden = VISIBLE;
			} else {
				buttonTitleOffToggledPress.hidden = VISIBLE;
				_labelToggledOffPressed.hidden = VISIBLE;
			}
		}
	}
}

-(void)buttonReleased:(CGPoint)location {
	
	if (self.isEnabled) {
		//check to see that the touch remains inside the button confines and only execute if true
		CGPathRef thePath = CGPathCreateWithRect(self.buttonBounds.frame, NULL);
		if (CGPathContainsPoint(thePath, NULL, location, YES)) {
			//change button on/off state here
			[self toggleButtonState];
			[self.delegate doButtonUp:self];

		} else { /*if the touch is moved outside the button confines*/	}
		CGPathRelease(thePath);
		
		//update button visual and update toggle state
		self.baseButton.hidden = VISIBLE;
		self.baseButtonPressed.hidden = HIDDEN;
		if (_buttonType == kIsToggleButton) {
			
			
			
			buttonTitleOnToggledPress.hidden = HIDDEN;
			_labelToggledOnPressed.hidden = HIDDEN;
			buttonTitleOffToggledPress.hidden = HIDDEN;
			_labelToggledOffPressed.hidden = HIDDEN;
			
			if (_on) {
				buttonTitleOnToggled.hidden = VISIBLE;
				_labelToggledOn.hidden = VISIBLE;
			} else {
				buttonTitleOffToggled.hidden = VISIBLE;
				_labelToggledOff.hidden = VISIBLE;
			}
			if (!self.isEnabled) {
				buttonTitleOffToggled.hidden = HIDDEN;
				_labelToggledOff.hidden = HIDDEN;
				buttonTitleOnToggled.hidden = HIDDEN;
				_labelToggledOn.hidden = HIDDEN;
				self.baseButton.hidden = HIDDEN;
			}
		}
		
		
		
	}
}



@end
