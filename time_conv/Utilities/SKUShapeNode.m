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
	
}

@end


@implementation SKUShapeNode

-(id)init {
	
	if (self = [super init]) {
		_boundingSize = CGSizeMake(500, 500);
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
		
		self.anchorPoint = CGPointZero;
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

	
//	CGAffineTransform transform = CGAffineTransformMake(1, 1, 0, 0, _boundingSize.width*0.75, _boundingSize.height*0.75);
//	CGPathRef newPath = CGPathCreateCopyByTransformingPath(_path, &transform);
	
	
	shapeLayer.path = _path;
	
//	CGRect enclosure = CGPathGetPathBoundingBox(_path);
//	NSLog(@"bounding: %f %f %f %f", enclosure.origin.x, enclosure.origin.y, enclosure.size.width, enclosure.size.height);
	
	
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	
	CGContextRef context = CGBitmapContextCreate(NULL, _boundingSize.width, _boundingSize.height, 8, 0, colorSpace, kCGImageAlphaPremultipliedLast);
	
//	CGContextTranslateCTM(context, _boundingSize.width*0.75, _boundingSize.height*0.75);
	
	[shapeLayer renderInContext:context];
	
	CGImageRef imageRef = CGBitmapContextCreateImage(context);
	CGContextRelease(context);
	CGColorSpaceRelease(colorSpace);
	
	
	SKTexture* tex = [SKTexture textureWithCGImage:imageRef];
	
	CGImageRelease(imageRef);
	
	
	self.texture = tex;
	self.size = _boundingSize;
	
}


-(void)setPath:(CGPathRef)path {
	_path = path;
	[self redrawTexture];
}



@end
