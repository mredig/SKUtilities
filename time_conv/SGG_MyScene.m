//
//  SGG_MyScene.m
//  time_conv
//
//  Created by Michael Redig on 1/22/14.
//  Copyright (c) 2014 Michael Redig. All rights reserved.
//

#import "SGG_MyScene.h"
#import "SGG_SKUtilities.h"

@interface SGG_MyScene() {
	
	CFTimeInterval prevTime;
	CFTimeInterval thisTime;
	
	
	CFTimeInterval globalCurrentTime;
	CFAbsoluteTime absTime;
	
//	SKLabelNode* interval;
	
	SGG_SKUtilities* sharedUtilties;
	
	bool firstupdate;
	
	int burr;
	float durr;
	
	
	CGPoint startInput;
	CGPoint endInput;
}

@end

@implementation SGG_MyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
		
		sharedUtilties = [SGG_SKUtilities sharedUtilities];
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
//        interval = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
//        
//        interval.text = @"Hello, World!";
//        interval.fontSize = 65;
//        interval.position = CGPointMake(CGRectGetMidX(self.frame),
//                                       CGRectGetMidY(self.frame));
//		interval.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
//        
//        [self addChild:interval];
		

		
		
		
    }
    return self;
}
#if TARGET_OS_IPHONE

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	
	for (UITouch* touch in touches) {
		CGPoint location = [touch locationInNode:self];
		[self inputBegan:location];
	}
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	
	for (UITouch* touch in touches) {
		CGPoint location = [touch locationInNode:self];
		[self inputEnded:location];
	}
	
}


#else
-(void)mouseDown:(NSEvent *)theEvent {
     /* Called when a mouse click occurs */
    
    CGPoint location = [theEvent locationInNode:self];
	
	prevTime = thisTime;
	
	thisTime = globalCurrentTime;
	
	
	[self inputBegan:location];

	
	
//	NSLog(@"time elapsed: %f", thisTime - prevTime);
	
}

-(void)mouseUp:(NSEvent *)theEvent {
	
	CGPoint location = [theEvent locationInNode:self];
	[self inputEnded:location];
	
}
#endif


-(void)inputBegan:(CGPoint)location {
	
//	CGPoint pi = CGPointMake(0, 15);
//	CGPoint pp = CGPointMake(300, 500);
//	
//	CFTimeInterval start = CFAbsoluteTimeGetCurrent();
//	NSLog(@"start %f", start);
//	
//	CGFloat distance;
//	for (int i = 0 ; i < 10000000; i++) {
////		CGVector newVec = [sharedUtilties normalizeVector:testVector];
//		distance = [sharedUtilties distanceBetween:pi and:pp];
//	}
//	
//	
//	CFTimeInterval end = CFAbsoluteTimeGetCurrent();
//	CGFloat difference = end - start;
//	NSLog(@"end %f, total time: %f", end, difference);
//
//	NSLog(@"distance %f", distance);
	
	startInput = location;

	
}

-(void)inputEnded:(CGPoint)location {
	
	endInput = location;
	
	
	
	CGVector v1 = CGVectorMake(startInput.x, startInput.y);
	CGVector v2 = CGVectorMake(endInput.x, endInput.y);
	
	CGVector normSum = [sharedUtilties addVectorA:v1 toVectorB:v2 andNormalize:YES];
	CGVector sum = [sharedUtilties addVectorA:v1 toVectorB:v2 andNormalize:NO];
	
	CGPoint normConv = CGPointMake(normSum.dx, normSum.dy);
	CGPoint sumConv = CGPointMake(sum.dx, sum.dy);
	
	CGFloat normDist = [sharedUtilties distanceBetween:CGPointZero and:normConv];
	CGFloat dist = [sharedUtilties distanceBetween:CGPointZero and:sumConv];
	
	NSLog(@"normSum: %f %f and distance: %f", normSum.dx, normSum.dy, normDist);
	NSLog(@"sum: %f %f and distance: %f", sum.dx, sum.dy, dist);
	
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
	
//	[sharedUtilties updateCurrentTime:currentTime];
	
	CFAbsoluteTime prevAbsTime = absTime;
	absTime = CFAbsoluteTimeGetCurrent();
	
	CFTimeInterval interval = absTime - prevAbsTime;
	
//	NSLog(@"Abs interval %f", interval);
	
	
	//	interval.text = [NSString stringWithFormat:@"%f", globalCurrentTime - thisTime];
//	NSLog(@"update interval %f", currentTime - globalCurrentTime);
	
	
	globalCurrentTime = currentTime;

	if (!firstupdate) {
		NSLog(@"launchtime: %f", currentTime);
		firstupdate = YES;
	}
	
	
}

@end
