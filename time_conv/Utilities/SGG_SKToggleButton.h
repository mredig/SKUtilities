//
//  SGG_SKToggleButton.h
//
//  Created by Michael Redig on 2/8/14.
//  Copyright (c) 2014 Michael Redig. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SGG_SKButton.h"

@interface SGG_SKToggleButton : SGG_SKButton

@property (nonatomic, readonly) konstantButtonVariation buttonType;
@property (nonatomic, readonly) bool on;





// all the following objects are uninitialized. You must initialize the according values for the button type you are creating and give them the proper values then you will run the according button setup method


//toggle button nodes
//you can either use labelnodes
@property (nonatomic, strong) SKLabelNode* labelToggledOn;
@property (nonatomic, strong) SKLabelNode* labelToggledOnPressed;
@property (nonatomic, strong) SKLabelNode* labelToggledOnDisabled;
@property (nonatomic, strong) SKLabelNode* labelToggledOff;
@property (nonatomic, strong) SKLabelNode* labelToggledOffPressed;
@property (nonatomic, strong) SKLabelNode* labelToggledOffDisabled;
//or textures
@property (nonatomic, strong) SKTexture* textureToggledOn;
@property (nonatomic, strong) SKTexture* textureToggledOnPressed;
@property (nonatomic, strong) SKTexture* textureToggledOnDisabled;
@property (nonatomic, strong) SKTexture* textureToggledOff;
@property (nonatomic, strong) SKTexture* textureToggledOffPressed;
@property (nonatomic, strong) SKTexture* textureToggledOffDisabled;

@property (nonatomic, assign) BOOL defaultState;


//titleSprites
@property (nonatomic, strong) SKSpriteNode* buttonTitleOnToggledPress;
@property (nonatomic, strong) SKSpriteNode* buttonTitleOnToggledDisabled;
@property (nonatomic, strong) SKSpriteNode* buttonTitleOnToggled;
@property (nonatomic, strong) SKSpriteNode* buttonTitleOffToggledPress;
@property (nonatomic, strong) SKSpriteNode* buttonTitleOffToggledDisabled;
@property (nonatomic, strong) SKSpriteNode* buttonTitleOffToggled;


-(void)setUpToggleButton;//call this AFTER you have properly set all the above properties



//these following methods ONLY affect the button state - they do NOT call methods as if they were pressed!
-(void)toggleButtonState; //still happens if button is disabled
-(void)toggleButtonOn;
-(void)toggleButtonOff;



@end
