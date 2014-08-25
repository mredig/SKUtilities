//
//  SKUShapeNode.h
//  SGG_SKUtilities
//
//  Created by Michael Redig on 4/7/14.
//  Copyright (c) 2014 Michael Redig. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SKUtilityConstants.h"
#import <QuartzCore/QuartzCore.h>

@interface SKUShapeNode : SKSpriteNode


/**
 The CGPath to be drawn (in the Node's coordinate space)
 */
@property (SK_NONATOMIC_IOSONLY) CGPathRef path;
//@property (SK_NONATOMIC_IOSONLY, readonly) CGPathRef drawPath;

/**
 The color to draw the path with. (for no stroke use [SKColor clearColor]). Defaults to [SKColor whiteColor].
 */
@property (SK_NONATOMIC_IOSONLY, retain) SKColor *strokeColor;

/**
 The color to fill the path with. Defaults to [SKColor clearColor] (no fill).
 */
@property (SK_NONATOMIC_IOSONLY, retain) SKColor *fillColor;

/**
 Sets the blend mode to use when composing the shape with the final framebuffer.
 @see SKNode.SKBlendMode
 */
//@property (SK_NONATOMIC_IOSONLY) SKBlendMode blendMode;



/**
 The width used to stroke the path. Widths larger than 2.0 may result in artifacts. Defaults to 1.0.
 */
@property (SK_NONATOMIC_IOSONLY) CGFloat lineWidth;

/**
 Add a glow to the path stroke of the specified width. Defaults to 0.0 (no glow)
 */
//@property (SK_NONATOMIC_IOSONLY) CGFloat glowWidth;


@property (nonatomic, assign) NSString* fillRule;
@property (nonatomic, assign) NSString* lineCap;
@property (nonatomic, assign) NSArray* lineDashPattern;
@property (nonatomic, assign) CGFloat lineDashPhase;
@property (nonatomic, assign) NSString* lineJoin;
@property (nonatomic, assign) CGFloat miterLimit;
@property (nonatomic, assign) CGFloat strokeEnd;
@property (nonatomic, assign) CGFloat strokeStart;

@property (nonatomic, assign) CGSize boundingSize;


@end
