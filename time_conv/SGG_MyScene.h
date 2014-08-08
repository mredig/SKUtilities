//
//  SGG_MyScene.h
//  time_conv
//

//  Copyright (c) 2014 Michael Redig. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SGG_SKMasterButton.h"

typedef enum {
    kStressButton,
	
} kButtonTypes;


@interface SGG_MyScene : SKScene <SGG_SKButtonDelegate, SGG_SKSliderDelegate>

@end
