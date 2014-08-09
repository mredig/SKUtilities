//
//  SKColor+Mixing.h
//  SGG_SKUtilities
//
//  Created by Michael Redig on 8/9/14.
//  Copyright (c) 2014 Michael Redig. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>



@interface SKColor (Mixing)

- (SKColor*)blendWithColor:(SKColor*)color2 alpha:(CGFloat)alpha2;



@end
