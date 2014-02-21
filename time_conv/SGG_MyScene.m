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
	
	SKSpriteNode* ship;
	
	int burr;
	float durr;
	
	CGFloat testValue;
	
	CGFloat anotherValue;
	
	CGPoint startInput;
	CGPoint endInput;
	
	CGPoint p0, p1, p2, p3;
}

@end

@implementation SGG_MyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
		
		sharedUtilties = [SGG_SKUtilities sharedUtilities];
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
		
		p0 = CGPointMake(0, 0);
		p1 = CGPointMake(1024, 0);
		p2 = CGPointMake(0, 768);
		p3 = CGPointMake(1024, 768);
		
		SGG_SKPushButton* pushButton = [SGG_SKPushButton node];
		pushButton.delegate = self;
		pushButton.textureBase = [SKTexture textureWithImageNamed:@"Spaceship"];
		pushButton.labelTitle = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
		pushButton.labelTitle.text = @"StressTest";
		pushButton.labelTitle.fontColor = [SKColor whiteColor];
		pushButton.labelTitlePress = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
		pushButton.labelTitlePress.text = @"StressTest";
		pushButton.labelTitlePress.fontColor = [SKColor redColor];
		pushButton.whichButton = kStressButton;
		[pushButton setUpButton];
		pushButton.position = CGPointMake(self.size.width/2, self.size.height/2);
		[self addChild:pushButton];

        
//        interval = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
//        
//        interval.text = @"Hello, World!";
//        interval.fontSize = 65;
//        interval.position = CGPointMake(CGRectGetMidX(self.frame),
//                                       CGRectGetMidY(self.frame));
//		interval.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
//        
//        [self addChild:interval];
		
//		startInput = CGPointMake(1024, 768);
//		
//		ship = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
//		ship.position = CGPointMake(512, 384);
//		[self addChild:ship];
//		
//		SKAction* rotate = [SKAction rotateByAngle:M_PI duration:1.5];
//		SKAction* repeat = [SKAction repeatActionForever:rotate];
//		[ship runAction:repeat];
		
    }
    return self;
}

-(void)drawBezierSegmentWithIterations:(NSInteger)iterations andPoint0:(CGPoint)p0 andPoint1:(CGPoint)p1 andPoint2:(CGPoint)p2 andPoint3:(CGPoint)p3 {
	
	for (int i = 0; i < iterations; i++) {
		SKSpriteNode* spriteSegment = [SKSpriteNode spriteNodeWithColor:[SKColor redColor] size:CGSizeMake(5, 5)];
		CGFloat t = (CGFloat)i / (CGFloat)iterations;
		//		spriteSegment.position = [self calculateBezierPoint:t andPoint0:p0 andPoint1:p1 andPoint2:p2 andPoint3:p3];
		spriteSegment.position = [sharedUtilties findPointOnBezierCurveWithPointA:p0 andPointB:p1 andPointC:p2 andPointD:p3 andPlaceOnCurve:t];
		spriteSegment.name = @"spriteSegment";
		[self addChild:spriteSegment];
	}
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
	
-(void)keyDown:(NSEvent *)theEvent {

	NSString *characters = [theEvent characters];
	if ([characters length]) {
		for (int s = 0; s<[characters length]; s++) {
			unichar character = [characters characterAtIndex:s];
			switch (character) {
			case ']':
				anotherValue += 100;
				break;
			case '[':
				anotherValue -= 100;
				break;
			}
		}
	}
}
#endif


-(void)inputBegan:(CGPoint)location {

	
	startInput = location;

//	[self stressTest];
	
}

-(void)inputEnded:(CGPoint)location {
	
	endInput = location;
	
	
//	CGVector facingVector1 = CGVectorMake(1, 0);
//	CGVector facingVector2 = CGVectorMake(1, 1);
//	
//	bool isBackstab = [sharedUtilties nodeAtPoint:startInput isBehindNodeAtPoint:endInput facingVector:facingVector2 isVectorNormal:NO withLatitudeOf:0.5];
//	
//	
//	NSLog(@"startPoint: %f %f end: %f %f", startInput.x, startInput.y, endInput.x, endInput.y);
//	NSLog(@"distance: %f", [sharedUtilties distanceBetween:startInput and:endInput]);
//	NSLog(@"is a backstab: %i", isBackstab);

	
//	NSLog(@"ship vec: %f %f", [sharedUtilties vectorFromRadianAngle:ship.zRotation]);
	
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
	
	[sharedUtilties updateCurrentTime:currentTime];
	
	CFAbsoluteTime prevAbsTime = absTime;
	absTime = CFAbsoluteTimeGetCurrent();
	
//	testValue = [sharedUtilties rampToValue:anotherValue fromCurrentValue:testValue withRampStep:0.3];
//	
//	NSLog(@"testValue: %f", testValue);
	
	

	if (!firstupdate) {
		NSLog(@"launchtime: %f", currentTime);
		firstupdate = YES;
	}
	
	
}

-(void)doButtonDown:(SGG_SKButton *)button {
}

-(void)doButtonUp:(SGG_SKButton *)button inBounds:(BOOL)inBounds {
	if (inBounds) {
		switch (button.whichButton) {
			case kStressButton:
				[self stressTest];
				break;
				
			default:
				break;
		}
	}

	
}

-(void)stressTest {
	
	NSTimeInterval timea = CFAbsoluteTimeGetCurrent();
//	NSLog(@"startTime: %f", timea);
	for (int i = 0; i < 10000000; i++) {
		[sharedUtilties findPointOnBezierCurveWithPointA:p0 andPointB:p1 andPointC:p2 andPointD:p3 andPlaceOnCurve:0.5];
//		[sharedUtilties calculateBezierPoint:0.5 andPoint0:p0 andPoint1:p1 andPoint2:p2 andPoint3:p3];
	}
	NSTimeInterval timeb = CFAbsoluteTimeGetCurrent();
	NSLog(@"time taken: %f", timeb - timea);

	
}

@end
