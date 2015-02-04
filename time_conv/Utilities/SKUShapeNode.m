//
//  SKUShapeNode.m
//  SGG_SKUtilities
//
//  Created by Michael Redig on 4/7/14.
//  Copyright (c) 2014 Michael Redig. All rights reserved.
//

#import "SKUShapeNode.h"

@interface SKUShapeNode() {
	
	CAShapeLayer* shapeLayer;
	
	CGSize boundingSize;
	
	SKSpriteNode* drawSprite;
	CGPoint defaultPosition;
	
	SKNode* null;
	
	
}

@end


@implementation SKUShapeNode

-(id)init {
	
	if (self = [super init]) {
		
		self.name = @"SKUShapeNode";
		
		null = [SKNode node];
		null.name = @"SKUShapeNodeNULL";
		[self addChild:null];
		
		drawSprite = [SKSpriteNode node];
		drawSprite.name = @"SKUShapeNodeDrawSprite";
		[null addChild:drawSprite];
//		_boundingSize = CGSizeMake(500, 500);
		_strokeColor = [SKColor whiteColor];
		_fillColor = [SKColor clearColor];
		_lineWidth = 1.0;
		_fillRule = kCAFillRuleNonZero;
		_lineCap = kCALineCapButt;
		_lineDashPattern = nil;
		_lineDashPhase = 0;
		_lineJoin = kCALineJoinMiter;
		_miterLimit = 10.0;
		_strokeEnd = 1.0;
		_strokeStart = 0.0;
		
		_anchorPoint = CGPointMake(0.5, 0.5);
	}

	return self;
}


-(void)redrawTexture {

	if (!_path) {
		return;
	}
	
	if (!shapeLayer) {
		shapeLayer = [CAShapeLayer layer];
	}
	
	shapeLayer.strokeColor = [_strokeColor CGColor];
	shapeLayer.fillColor = [_fillColor CGColor];
	shapeLayer.lineWidth = _lineWidth;
	shapeLayer.fillRule = _fillRule;
	shapeLayer.lineCap = _lineCap;
	shapeLayer.lineDashPattern = _lineDashPattern;
	shapeLayer.lineDashPhase = _lineDashPhase;
	shapeLayer.lineJoin = _lineJoin;
	shapeLayer.miterLimit = _miterLimit;
	shapeLayer.strokeEnd = _strokeEnd;
	shapeLayer.strokeStart = _strokeStart;

	
	
	
	
	CGRect enclosure = CGPathGetPathBoundingBox(_path);
//	NSLog(@"bounding: %f %f %f %f", enclosure.origin.x, enclosure.origin.y, enclosure.size.width, enclosure.size.height);
	CGPoint enclosureOffset = CGPointMake(enclosure.origin.x - _lineWidth, enclosure.origin.y - _lineWidth);

	CGAffineTransform transform = CGAffineTransformMake(1, 0, 0, 1, -enclosureOffset.x, -enclosureOffset.y);
	CGPathRef newPath = CGPathCreateCopyByTransformingPath(_path, &transform);

	shapeLayer.path = newPath;
	
	boundingSize = CGSizeMake(enclosure.size.width + _lineWidth * 2, enclosure.size.height + _lineWidth * 2);
	
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	
	CGContextRef context = CGBitmapContextCreate(NULL, boundingSize.width, boundingSize.height, 8, 0, colorSpace, kCGImageAlphaPremultipliedLast); //fixing this warning with a proper CGBitmapInfo enum causes the build to crash - Perhaps I did something wrong?
//	CGContextRef context = CGBitmapContextCreate(NULL, _boundingSize.width, _boundingSize.height, 8, 0, colorSpace, kCGBitmapAlphaInfoMask);
	
//	CGContextTranslateCTM(context, enclosureOffset.x, enclosureOffset.y);
	
	[shapeLayer renderInContext:context];
	
	CGImageRef imageRef = CGBitmapContextCreateImage(context);
	CGContextRelease(context);
	CGColorSpaceRelease(colorSpace);
	CGPathRelease(newPath);
	
	
	SKTexture* tex = [SKTexture textureWithCGImage:imageRef];
	
	CGImageRelease(imageRef);
	
	
	drawSprite.texture = tex;
	drawSprite.size = boundingSize;
	drawSprite.anchorPoint = CGPointZero;
	defaultPosition = CGPointMake(enclosureOffset.x, enclosureOffset.y);
	drawSprite.position = defaultPosition;
	[self setAnchorPoint:_anchorPoint];
	
}

-(void)setAnchorPoint:(CGPoint)anchorPoint {
	
	_anchorPoint = anchorPoint;
	
//	drawSprite.position = defaultPosition;
	null.position = CGPointMake(boundingSize.width * (0.5 - anchorPoint.x), boundingSize.height * (0.5 - anchorPoint.y));
	
//	NSLog(@"defx: %f defy: %f boundw: %f boundh: %f finalx: %f finaly: %f", defaultPosition.x, defaultPosition.y, boundingSize.width, boundingSize.height, drawSprite.position.x, drawSprite.position.y);
	
}


-(void)setPath:(CGPathRef)path {
	_path = path;
	[self redrawTexture];
}

-(void)setFillColor:(SKColor *)fillColor {
	
	_fillColor = fillColor;
	[self redrawTexture];
	
}

-(void)setStrokeEnd:(CGFloat)strokeEnd {

	_strokeEnd = strokeEnd;
	[self redrawTexture];
	
}

-(void)setStrokeStart:(CGFloat)strokeStart {
	
	_strokeStart = strokeStart;
	[self redrawTexture];
	
}



@end
