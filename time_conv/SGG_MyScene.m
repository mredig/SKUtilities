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

-(void)mouseDown:(NSEvent *)theEvent {
     /* Called when a mouse click occurs */
    
//    CGPoint location = [theEvent locationInNode:self];
	
	prevTime = thisTime;
	
	thisTime = globalCurrentTime;
	
	
	CGPoint i = CGPointMake(3, 4);
	CGPoint p = CGPointMake(1, 2);
	CGVector testVector = CGVectorMake(i.x - p.x, i.y - p.y);
	
	CFTimeInterval start = CFAbsoluteTimeGetCurrent();
	NSLog(@"start %f", start);
	
	for (int i = 0 ; i < 10000000; i++) {
		CGVector newVec = [sharedUtilties normalizeVector:testVector];
	}
	
	CFTimeInterval end = CFAbsoluteTimeGetCurrent();
	CGFloat difference = end - start;
	NSLog(@"end %f, total time: %f", end, difference);
	
	
//	NSLog(@"time elapsed: %f", thisTime - prevTime);
	
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
