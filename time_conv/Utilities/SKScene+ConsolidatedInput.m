//
//  SKUScene.m
//  SGG_SKUtilities
//
//  Created by Michael Redig on 3/11/14.
//  Copyright (c) 2014 Michael Redig. All rights reserved.
//

#import "SKScene+ConsolidatedInput.h"

@implementation SKScene (ConsolidatedInput)




#if TARGET_OS_IPHONE

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch* touch = [touches anyObject];
	CGPoint location = [touch locationInNode:self];
	NSInteger touchCount = touch.tapCount;
	NSTimeInterval intervalTime = touch.timestamp;
	NSArray* keys = [NSArray arrayWithObjects:@"intervalTime", @"inputIteration", @"buttonNumber", @"event", @"touch", nil];
	NSArray* objects = [NSArray arrayWithObjects:
						[NSNumber numberWithDouble:intervalTime],
						[NSNumber numberWithInteger:touchCount],
						[NSNumber numberWithInteger:0],
						event,
						touch,
						nil];
	NSDictionary* eventDict = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
	[self inputBegan:location withEventDictionary:eventDict];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch* touch = [touches anyObject];
	CGPoint location = [touch locationInNode:self];
	NSInteger touchCount = touch.tapCount;
	NSTimeInterval intervalTime = touch.timestamp;

	NSArray* keys = [NSArray arrayWithObjects:@"intervalTime", @"inputIteration", @"buttonNumber", @"event", @"touch", nil];
	NSArray* objects = [NSArray arrayWithObjects:
						[NSNumber numberWithDouble:intervalTime],
						[NSNumber numberWithInteger:touchCount],
						[NSNumber numberWithInteger:0],
						event,
						touch,
						nil];
	NSDictionary* eventDict = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
	[self inputMoved:location withEventDictionary:eventDict];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch* touch = [touches anyObject];
	CGPoint location = [touch locationInNode:self];
	NSInteger touchCount = touch.tapCount;
	NSTimeInterval intervalTime = touch.timestamp;

	NSArray* keys = [NSArray arrayWithObjects:@"intervalTime", @"inputIteration", @"buttonNumber", @"event", @"touch", nil];
	NSArray* objects = [NSArray arrayWithObjects:
						[NSNumber numberWithDouble:intervalTime],
						[NSNumber numberWithInteger:touchCount],
						[NSNumber numberWithInteger:0],
						event,
						touch,
						nil];
	NSDictionary* eventDict = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
	[self inputEnded:location withEventDictionary:eventDict];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch* touch = [touches anyObject];
	CGPoint location = [touch locationInNode:self];
	NSInteger touchCount = touch.tapCount;
	NSTimeInterval intervalTime = touch.timestamp;
	
	NSArray* keys = [NSArray arrayWithObjects:@"intervalTime", @"inputIteration", @"buttonNumber", @"event", @"touch", nil];
	NSArray* objects = [NSArray arrayWithObjects:
						[NSNumber numberWithDouble:intervalTime],
						[NSNumber numberWithInteger:touchCount],
						[NSNumber numberWithInteger:0],
						event,
						touch,
						nil];
	NSDictionary* eventDict = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
	[self inputEnded:location withEventDictionary:eventDict];
}

#else

-(void)mouseDown:(NSEvent *)theEvent {
	CGPoint location = [theEvent locationInNode:self];
	NSTimeInterval intervalTime = theEvent.timestamp;
	NSInteger clickCount = theEvent.clickCount;
	NSInteger buttonNumber = theEvent.buttonNumber;
	NSArray* keys = [NSArray arrayWithObjects:@"intervalTime", @"inputIteration", @"buttonNumber", @"event", nil];
	NSArray* objects = [NSArray arrayWithObjects:[NSNumber numberWithDouble:intervalTime],
												 [NSNumber numberWithInteger:clickCount],
												 [NSNumber numberWithInteger:buttonNumber],
												 theEvent,
												  nil];
				
	NSDictionary* eventDict = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
	[self inputBegan:location withEventDictionary:eventDict];
}

-(void)mouseDragged:(NSEvent *)theEvent {

	CGPoint location = [theEvent locationInNode:self];
	NSTimeInterval intervalTime = theEvent.timestamp;
	NSInteger clickCount = theEvent.clickCount;
	NSInteger buttonNumber = theEvent.buttonNumber;
	
	NSArray* keys = [NSArray arrayWithObjects:@"intervalTime", @"inputIteration", @"buttonNumber", @"event", nil];
	NSArray* objects = [NSArray arrayWithObjects:[NSNumber numberWithDouble:intervalTime],
						[NSNumber numberWithInteger:clickCount],
						[NSNumber numberWithInteger:buttonNumber],
						theEvent,
						nil];
	
	NSDictionary* eventDict = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
	[self inputMoved:location withEventDictionary:eventDict];
}

-(void)mouseUp:(NSEvent *)theEvent {
	CGPoint location = [theEvent locationInNode:self];
	NSTimeInterval intervalTime = theEvent.timestamp;
	NSInteger clickCount = theEvent.clickCount;
	NSInteger buttonNumber = theEvent.buttonNumber;
	
	NSArray* keys = [NSArray arrayWithObjects:@"intervalTime", @"inputIteration", @"buttonNumber", @"event", nil];
	NSArray* objects = [NSArray arrayWithObjects:[NSNumber numberWithDouble:intervalTime],
						[NSNumber numberWithInteger:clickCount],
						[NSNumber numberWithInteger:buttonNumber],
						theEvent,
						nil];
	
	NSDictionary* eventDict = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
	[self inputEnded:location withEventDictionary:eventDict];

}

-(void)mouseExited:(NSEvent *)theEvent {
	CGPoint location = [theEvent locationInNode:self];
	NSTimeInterval intervalTime = theEvent.timestamp;
	NSInteger clickCount = theEvent.clickCount;
	NSInteger buttonNumber = theEvent.buttonNumber;
	
	NSArray* keys = [NSArray arrayWithObjects:@"intervalTime", @"inputIteration", @"buttonNumber", @"event", nil];
	NSArray* objects = [NSArray arrayWithObjects:[NSNumber numberWithDouble:intervalTime],
						[NSNumber numberWithInteger:clickCount],
						[NSNumber numberWithInteger:buttonNumber],
						theEvent,
						nil];
	
	NSDictionary* eventDict = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
	[self inputEnded:location withEventDictionary:eventDict];
}

-(void)rightMouseDown:(NSEvent *)theEvent {
	
	CGPoint location = [theEvent locationInNode:self];
	NSTimeInterval intervalTime = theEvent.timestamp;
	NSInteger clickCount = theEvent.clickCount;
	NSInteger buttonNumber = theEvent.buttonNumber;
	NSArray* keys = [NSArray arrayWithObjects:@"intervalTime", @"inputIteration", @"buttonNumber", @"event", nil];
	NSArray* objects = [NSArray arrayWithObjects:[NSNumber numberWithDouble:intervalTime],
						[NSNumber numberWithInteger:clickCount],
						[NSNumber numberWithInteger:buttonNumber],
						theEvent,
						nil];
	
	NSDictionary* eventDict = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
	[self inputBegan:location withEventDictionary:eventDict];}

-(void)rightMouseDragged:(NSEvent *)theEvent {
	
	CGPoint location = [theEvent locationInNode:self];
	NSTimeInterval intervalTime = theEvent.timestamp;
	NSInteger clickCount = theEvent.clickCount;
	NSInteger buttonNumber = theEvent.buttonNumber;
	
	NSArray* keys = [NSArray arrayWithObjects:@"intervalTime", @"inputIteration", @"buttonNumber", @"event", nil];
	NSArray* objects = [NSArray arrayWithObjects:[NSNumber numberWithDouble:intervalTime],
						[NSNumber numberWithInteger:clickCount],
						[NSNumber numberWithInteger:buttonNumber],
						theEvent,
						nil];
	
	NSDictionary* eventDict = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
	[self inputMoved:location withEventDictionary:eventDict];
}

-(void)rightMouseUp:(NSEvent *)theEvent {
	CGPoint location = [theEvent locationInNode:self];
	NSTimeInterval intervalTime = theEvent.timestamp;
	NSInteger clickCount = theEvent.clickCount;
	NSInteger buttonNumber = theEvent.buttonNumber;
	
	NSArray* keys = [NSArray arrayWithObjects:@"intervalTime", @"inputIteration", @"buttonNumber", @"event", nil];
	NSArray* objects = [NSArray arrayWithObjects:[NSNumber numberWithDouble:intervalTime],
						[NSNumber numberWithInteger:clickCount],
						[NSNumber numberWithInteger:buttonNumber],
						theEvent,
						nil];
	
	NSDictionary* eventDict = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
	[self inputEnded:location withEventDictionary:eventDict];

}

-(void)otherMouseDown:(NSEvent *)theEvent {
	CGPoint location = [theEvent locationInNode:self];
	NSTimeInterval intervalTime = theEvent.timestamp;
	NSInteger clickCount = theEvent.clickCount;
	NSInteger buttonNumber = theEvent.buttonNumber;
	NSArray* keys = [NSArray arrayWithObjects:@"intervalTime", @"inputIteration", @"buttonNumber", @"event", nil];
	NSArray* objects = [NSArray arrayWithObjects:[NSNumber numberWithDouble:intervalTime],
						[NSNumber numberWithInteger:clickCount],
						[NSNumber numberWithInteger:buttonNumber],
						theEvent,
						nil];
	
	NSDictionary* eventDict = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
	[self inputBegan:location withEventDictionary:eventDict];
}

-(void)otherMouseDragged:(NSEvent *)theEvent {
	
	CGPoint location = [theEvent locationInNode:self];
	NSTimeInterval intervalTime = theEvent.timestamp;
	NSInteger clickCount = theEvent.clickCount;
	NSInteger buttonNumber = theEvent.buttonNumber;
	
	NSArray* keys = [NSArray arrayWithObjects:@"intervalTime", @"inputIteration", @"buttonNumber", @"event", nil];
	NSArray* objects = [NSArray arrayWithObjects:[NSNumber numberWithDouble:intervalTime],
						[NSNumber numberWithInteger:clickCount],
						[NSNumber numberWithInteger:buttonNumber],
						theEvent,
						nil];
	
	NSDictionary* eventDict = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
	[self inputMoved:location withEventDictionary:eventDict];
}

-(void)otherMouseUp:(NSEvent *)theEvent {
	CGPoint location = [theEvent locationInNode:self];
	NSTimeInterval intervalTime = theEvent.timestamp;
	NSInteger clickCount = theEvent.clickCount;
	NSInteger buttonNumber = theEvent.buttonNumber;
	
	NSArray* keys = [NSArray arrayWithObjects:@"intervalTime", @"inputIteration", @"buttonNumber", @"event", nil];
	NSArray* objects = [NSArray arrayWithObjects:[NSNumber numberWithDouble:intervalTime],
						[NSNumber numberWithInteger:clickCount],
						[NSNumber numberWithInteger:buttonNumber],
						theEvent,
						nil];
	
	NSDictionary* eventDict = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
	[self inputEnded:location withEventDictionary:eventDict];

}

#endif


-(void)inputBegan:(CGPoint)location withEventDictionary:(NSDictionary*)eventDict {
	
}

-(void)inputMoved:(CGPoint)location withEventDictionary:(NSDictionary*)eventDict {
	
}

-(void)inputEnded:(CGPoint)location withEventDictionary:(NSDictionary*)eventDict {
	
}

@end
