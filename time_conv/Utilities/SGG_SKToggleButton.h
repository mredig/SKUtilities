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
@property (nonatomic, assign) SKTexture* textureToggledOn;
@property (nonatomic, assign) SKTexture* textureToggledOnPressed;
@property (nonatomic, assign) SKTexture* textureToggledOnDisabled;
@property (nonatomic, assign) SKTexture* textureToggledOff;
@property (nonatomic, assign) SKTexture* textureToggledOffPressed;
@property (nonatomic, assign) SKTexture* textureToggledOffDisabled;

@property (nonatomic, assign) BOOL defaultState;


-(void)setUpToggleButton;//call this AFTER you have properly set all the above properties



//these following methods ONLY affect the button state - they do NOT call methods as if they were pressed!
-(void)toggleButtonState; //still happens if button is disabled
-(void)toggleButtonOn;
-(void)toggleButtonOff;



@end
