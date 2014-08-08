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
	
	
	NSMutableArray* points;
}

@end

@implementation SGG_MyScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
		
		sharedUtilties = [SGG_SKUtilities sharedUtilities];
		
		points = [[NSMutableArray alloc] init];
        
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
		//		[self addChild:pushButton];
		
		SKUMultiLineLabelNode* multiLineLabel = [SKUMultiLineLabelNode labelNodeWithFontNamed:@"Futura"];
//		multiLineLabel.lineSpacing = 30;
		multiLineLabel.text = @"\tTurn this skiff around! Absolutely. And we're going to be here every day. I don't care if it takes from now till the end of Shrimpfest. I need a fake passport, preferably to France… I like the way they think. That's so you can videotape it when they put you in a naked pyramid and point to your Charlie Browns. \n\tI guess you can say I'm buy-curious. You go buy a tape recorder and record yourself for a whole day. I think you'll be surprised at some of your phrasing. It's The Final Countdown Dead Dove DO NOT EAT. I believe you will find the dessert to be both engrossing and high-grossing! So we don't get dessert? I could use a leather jacket for when I'm on my hog and have to go into a controlled slide. Happy."; //bluthipsum.com
		multiLineLabel.paragraphWidth = 500;
		multiLineLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
		multiLineLabel.strokeWidth = 3;
		multiLineLabel.strokeColor = [SKColor greenColor];
		multiLineLabel.paragraphHeight = 1000;
		multiLineLabel.name = @"multiLabel";
		multiLineLabel.position = CGPointMake(self.size.width/2, self.size.height/2);
//		[self addChild:multiLineLabel];
		
//		NSLog(@"line: %f", multiLineLabel.lineSpacing);
		
//		[self drawBezierSegmentWithIterations:50 andPoint0:p0 andPoint1:p1 andPoint2:p2 andPoint3:p3];
		
		SGG_SKSlider* newSlider = [SGG_SKSlider node];
		newSlider.position = CGPointMake(200, 200);
		newSlider.maxValue = 1.0;
		newSlider.minValue = 0.0;
		newSlider.continuous = YES;
		newSlider.name = @"newSlider";
		[self addChild:newSlider];
		
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


#else


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

-(BOOL)isUserInteractionEnabled {
	return YES;
}

#endif


-(void)inputBegan:(CGPoint)location withEventDictionary:(NSDictionary *)eventDict {
	
//	SKNode* label = [self childNodeWithName:@"multiLabel"];
//	label.position = location;
	
	[points removeAllObjects];
	[points addObject:[sharedUtilties getStringFromPoint:location]];
	
	SGG_SKSlider* newSlider = (SGG_SKSlider*)[self childNodeWithName:@"newSlider"];
//	newSlider.nobTexturePressed = [SKTexture textureWithImageNamed:@"Spaceship"];
}

-(void)inputMoved:(CGPoint)location withEventDictionary:(NSDictionary *)eventDict {
	
	CGPoint previousLocation = [sharedUtilties getCGPointFromString:points[points.count - 1]];
	
	
	CGPoint locationDifference = [sharedUtilties pointAddA:location toPointB:[sharedUtilties pointInverse:previousLocation]];
	
	
	SKNode* label = [self childNodeWithName:@"multiLabel"];
	label.position = [sharedUtilties pointAddA:locationDifference toPointB:label.position];
	
	[points addObject:[sharedUtilties getStringFromPoint:location]];
	/* //bezier testing stuff
	[self enumerateChildNodesWithName:@"spriteSegment" usingBlock:^(SKNode *node, BOOL *stop) {
		[node removeFromParent];
	}];
	p2 = location;
	[self drawBezierSegmentWithIterations:50 andPoint0:p0 andPoint1:p1 andPoint2:p2 andPoint3:p3];
*/
	
}

-(void)inputEnded:(CGPoint)location withEventDictionary:(NSDictionary *)eventDict {
	
//	SKNode* label = [self childNodeWithName:@"multiLabel"];
//	label.position = location;
	
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
	
	[sharedUtilties updateCurrentTime:currentTime];
	
	CFAbsoluteTime prevAbsTime = absTime;
	absTime = CFAbsoluteTimeGetCurrent();
	
	
	
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
