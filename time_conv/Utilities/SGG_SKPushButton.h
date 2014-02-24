//
//
//  Created by Michael Redig on 12/11/13.
//  Copyright (c) 2013 Michael Redig. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SGG_SKButton.h"


@interface SGG_SKPushButton : SGG_SKButton



// all the following objects are uninitialized. You must initialize the according values for the button type you are creating and give them the proper values then you will run the according button setup method



//regular button nodes
//you can either use labelnodes
@property (nonatomic, strong) SKLabelNode* labelTitle;
@property (nonatomic, strong) SKLabelNode* labelTitlePress; //optional
@property (nonatomic, strong) SKLabelNode* labelTitleDisabled; //optional

//or textures 
@property (nonatomic, assign) SKTexture* textureTitle;
@property (nonatomic, assign) SKTexture* textureTitlePressed; //optional
@property (nonatomic, assign) SKTexture* textureTitleDisabled; //optional
@property (nonatomic, readonly) konstantButtonVariation buttonType;


//title sprites
@property (nonatomic, strong) SKSpriteNode* buttonTitle;
@property (nonatomic, strong) SKSpriteNode* buttonTitlePress;
@property (nonatomic, strong) SKSpriteNode* buttonTitleDisabled;

//call ONE of these AFTER you have properly set all the above properties
-(void)setUpButton;


@end
