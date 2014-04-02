//
//  SKUMultiLineLabelNode.h
//  SGG_SKUtilities
//
//  Modified by Michael Redig on 3/11/14.
//	Original Credit goes to Chris Allwein of Downright Simple(c)
//	License remains the same

#import <SpriteKit/SpriteKit.h>
#import "SKUtilityConstants.h"

@interface SKUMultiLineLabelNode : SKSpriteNode

@property(retain, nonatomic) SKColor* fontColor;
@property(copy, nonatomic) NSString* fontName;
@property(nonatomic) CGFloat fontSize;
@property(nonatomic) SKLabelHorizontalAlignmentMode horizontalAlignmentMode;
@property(copy, nonatomic) NSString* text;
@property(nonatomic) SKLabelVerticalAlignmentMode verticalAlignmentMode;
@property(nonatomic, assign) CGFloat paragraphWidth;
@property(nonatomic, assign) CGFloat lineSpacing; //measures in points
@property(nonatomic, assign) CGFloat strokeWidth;
@property(retain, nonatomic) SKColor* strokeColor;

+ (instancetype)labelNodeWithFontNamed:(NSString *)fontName;
- (instancetype)initWithFontNamed:(NSString *)fontName;


@end
