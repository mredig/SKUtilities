//
//
//  Created by Michael Redig on 12/11/13.
//  Copyright (c) 2013 Michael Redig. All rights reserved.
//

#import "SGG_SKPushButton.h"

@interface SGG_SKPushButton (){
	

	
}
@end

@implementation SGG_SKPushButton

@synthesize delegate;

#pragma mark INIT and STUFF
-(id) init {
	if (self = [super init]) {
		// do initialization here
	}
	return self;
}




#pragma mark BUTTON SETUPS

-(void)setUpButton {
	
	_buttonType = kIsRegularButton;
	
	[super setUpBase];
	
	[self setUpTitle];
	
	[super setButtonSize];
	
	[super setUpAnchor];

}


#pragma mark BUTTON COMPONENTS


-(void)setUpTitle {

	BOOL titleIsSet = NO;
	//check if there's a title label and apply for both neutral and pressed states
	if (_labelTitle) {
		_labelTitle.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
		_labelTitle.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
		[self.anchorMover addChild:_labelTitle];
		titleIsSet = YES;
	}
	
	if (_labelTitlePress) {
		_labelTitlePress.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
		_labelTitlePress.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
		[self.anchorMover addChild:_labelTitlePress];
	} else if (!_labelTitlePress && _labelTitle) { //if the press hasn't been inited, but the neutral has
		_labelTitlePress = [SKLabelNode labelNodeWithFontNamed:self.labelTitle.fontName];
		_labelTitlePress.fontColor = _labelTitle.fontColor;
		_labelTitlePress.fontSize = _labelTitle.fontSize;
		_labelTitlePress.text = _labelTitle.text;
		_labelTitlePress.blendMode = _labelTitle.blendMode;
		_labelTitlePress.color = _labelTitle.color;
		_labelTitlePress.colorBlendFactor = _labelTitle.colorBlendFactor;
		_labelTitlePress.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
		_labelTitlePress.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
		[self.anchorMover addChild:_labelTitlePress];
	}
	_labelTitlePress.hidden = HIDDEN;
	
	if (_labelTitleDisabled) {
		_labelTitleDisabled.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
		_labelTitleDisabled.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
		[self.anchorMover addChild:_labelTitleDisabled];
	}
	_labelTitleDisabled.hidden = HIDDEN;
	
	
	//check if there's a title texture and apply for both neutral and pressed states (note, both texture and label can appear at the same time... careful)
	
	if (_textureTitle) {
		_buttonTitle = [SKSpriteNode spriteNodeWithTexture:_textureTitle];
		[self.anchorMover addChild:_buttonTitle];
		titleIsSet = YES;
	}
	
	if (_textureTitlePressed) {
		_buttonTitlePress = [SKSpriteNode spriteNodeWithTexture:_textureTitlePressed];
		[self.anchorMover addChild:_buttonTitlePress];
	} else if (!_textureTitlePressed && _textureTitle) {
		_buttonTitlePress = [SKSpriteNode spriteNodeWithTexture:_textureTitle];
		[self.anchorMover addChild:_buttonTitlePress];
	}
	_buttonTitlePress.hidden = HIDDEN;
	
	if (_textureTitleDisabled) {
		_buttonTitleDisabled = [SKSpriteNode spriteNodeWithTexture:_textureTitleDisabled];
		[self.anchorMover addChild:_buttonTitleDisabled];
	}
	_buttonTitleDisabled.hidden = HIDDEN;
	
	
	if (!titleIsSet) {
		if (self.debugMode) {
			NSLog(@"Warning: Button setup requires a title texture or label to properly function. Type: %i Enumerator: %i Button: %@", self.buttonType, self.whichButton, self);
		}
	}
}





#pragma mark BUTTON METHODS

-(void)enableButton {
	[super enableButton];
	
	_labelTitle.hidden = VISIBLE;
	
	_buttonTitle.hidden = VISIBLE;
	_buttonTitleDisabled.hidden = HIDDEN;
	_labelTitleDisabled.hidden = HIDDEN;
	
}

-(void)disableButton {
	[self enableButton]; //reset
	[super disableButton];
	
	if (self.disableType == kButtonDisableTypeAlternateTexture) {
		_labelTitle.hidden = HIDDEN;
		_labelTitlePress.hidden = HIDDEN;
		_buttonTitle.hidden = HIDDEN;
		_buttonTitleDisabled.hidden = VISIBLE;
		_labelTitleDisabled.hidden = VISIBLE;
	}
}




-(void)buttonPressed {
	
	
	if (self.isEnabled) {
	//do button execution

		[self.delegate doButtonDown:self];

	//update button visual
		self.baseButton.hidden = HIDDEN;
		self.baseButtonPressed.hidden = VISIBLE;
		if (_buttonType == kIsRegularButton) {
			
			_buttonTitle.hidden = HIDDEN;
			_buttonTitlePress.hidden = VISIBLE;
			
			_labelTitle.hidden = HIDDEN;
			_labelTitlePress.hidden = VISIBLE;
		}
	}
}

-(void)buttonReleased:(CGPoint)location {
	
	if (self.isEnabled) {
	
		//update button visual and update toggle state
		self.baseButtonPressed.hidden = HIDDEN;
		_buttonTitlePress.hidden = HIDDEN;
		_labelTitlePress.hidden = HIDDEN;
		_buttonTitle.hidden = VISIBLE;
		_labelTitle.hidden = VISIBLE;
		self.baseButton.hidden = VISIBLE;
	
		//check to see that the touch remains inside the button confines and only execute if true
		CGPathRef thePath = CGPathCreateWithRect(self.buttonBounds.frame, NULL);
		if (CGPathContainsPoint(thePath, NULL, location, YES)) {
//			SGG_MethodExecutor* executor = (SGG_MethodExecutor*) self.methodExecutor;
//			[executor doButtonUp:self];
//			NSLog(@"contained");

			[self.delegate doButtonUp:self inBounds:YES];
			
			
		} else { /*if the touch is moved outside the button confines*/
			
			[self.delegate doButtonUp:self inBounds:NO];
		}
		
		CGPathRelease(thePath);


	}
}



@end
