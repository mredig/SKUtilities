//
//  SGG_SKButton.h
//
//  Created by Michael Redig on 2/8/14.
//  Copyright (c) 2014 Michael Redig. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SGG_SKUtilities.h"

@class SGG_SKButton;

@protocol SGG_SKButtonDelegate   //define delegate protocol
-(void)doButtonDown:(SGG_SKButton*)button;
-(void)doButtonUp:(SGG_SKButton*)button inBounds:(BOOL)inBounds;
@end //end protocol

@interface SGG_SKButton : SKNode


typedef enum {
	kIsToggleButton,
	kIsRegularButton,
	kIsNoBackgroundButton,
	kIsSliderButton,
} konstantButtonVariation;

typedef enum {
	kButtonDisableTypeDim,
	kButtonDisableTypeOpacityHalf,
	kButtonDisableTypeOpacityNone,
	kButtonDisableTypeAlternateTexture, //falls back to dim without proper textures set
	kButtonDisableTypeNoDifference, 
} kButtonDisableTypes;

@property (nonatomic, assign) bool debugMode; //used for debugging

@property (nonatomic, weak) id <SGG_SKButtonDelegate> delegate; //define MyClassDelegate as delegate
@property (nonatomic, assign) int whichButton; //used for enumeration of buttons
@property (nonatomic, assign) bool isEnabled; //turns button functionality on or off
@property (nonatomic, assign) CGPoint anchorPoint; // anchor point for entire button (may be unpredictable) does not work with buttons triggered upon release
@property (nonatomic, strong) NSMutableDictionary* buttonDictionary;
@property (nonatomic, assign) CGSize touchAreaSize; //used to override the default button size (defaults to the size of textureBase)
@property (nonatomic, strong) SKNode* anchorMover; //you may add children to this AFTER the button has been properly set up
@property (nonatomic, assign) kButtonDisableTypes disableType;


// all the following objects are uninitialized. You must initialize the according values for the button type you are creating and give them the proper values then you will run the according button setup method

// all buttons require textureBase
// toggle buttons require enableTex and disableTex

//all buttons
@property (nonatomic, strong) SKSpriteNode* buttonBounds;

@property (nonatomic, strong) SKTexture* textureBase;
@property (nonatomic, strong) SKTexture* textureBasePressed; //optional

@property (nonatomic, strong) SKTexture* textureDisabled;


//for internal use primarily
@property (nonatomic, strong) SKSpriteNode* baseButton;
@property (nonatomic, strong) SKSpriteNode* baseButtonPressed;

@property (nonatomic, strong) SKSpriteNode* baseButtonDisabled;


//for internal use primarily
-(void)setUpBase;
-(void)setButtonSize;
-(void)setUpAnchor;


//button disabling and reenabling
-(void)enableButton;
-(void)disableButton; //if you subclass with these methods, it's wise to call the super methods in the subclassed ones. Also, it's wise to reset the state of the button by enabling the button before disabling it

@end
