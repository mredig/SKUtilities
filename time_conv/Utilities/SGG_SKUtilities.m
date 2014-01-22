//
//  SGG_SKUtilities.m
//  Schmup
//
//  Created by Michael Redig on 1/1/14.
//  Copyright (c) 2014 Michael Redig. All rights reserved.
//
// version 1.0.5

#import "SGG_SKUtilities.h"


@interface SGG_SKUtilities() {

	
}
@end

@implementation SGG_SKUtilities

static SGG_SKUtilities* sharedUtilities = Nil;

+(SGG_SKUtilities*) sharedUtilities {
	
	if (sharedUtilities == nil) {
		
		sharedUtilities = [[SGG_SKUtilities alloc] init];
	}
	
	
	return sharedUtilities;
}

-(id) init {
	if (self = [super init]) {
		//		NSLog(@"initialized");
	}
	
	[self initialSetup];
	
	return self;
}

-(void)initialSetup {
	
	_radiansToDegreesConversionFactor = (180 / M_PI);
	_degreesToRadiansConversionFactor = (M_PI / 180);
	
	
}



#pragma mark DISTANCE FUNCTIONS
-(CGFloat)distanceBetween : (CGPoint) p1 and: (CGPoint)p2 {
	return hypotf(p2.x - p1.x, p2.y - p1.y);
	
	//    return sqrt(pow(p2.x-p1.x,2)+pow(p2.y-p1.y,2));
}


-(BOOL)distanceBetweenPointA:(CGPoint)pointA andPointB:(CGPoint)pointB isWithinXDistance:(CGFloat)distance {
	
	CGFloat deltaX = pointA.x - pointB.x;
	CGFloat deltaY = pointA.y - pointB.y;
	
	return (deltaX * deltaX) + (deltaY * deltaY) <= distance * distance;
	
}


-(BOOL)distanceBetweenPointA:(CGPoint)pointA andPointB:(CGPoint)pointB isWithinXDistancePreSquared:(CGFloat)distanceSquared {
	
	CGFloat deltaX = pointA.x - pointB.x;
	CGFloat deltaY = pointA.y - pointB.y;
	
	return (deltaX * deltaX) + (deltaY * deltaY) <= distanceSquared;
	
}

#pragma mark ORIENTATION

-(CGFloat) orientTo:(CGPoint)point1 from:(CGPoint)point2 {
	//may return an incorrect angle
	CGFloat deltaX = point2.x - point1.x;
	CGFloat deltaY = point2.y - point1.y;
	return atan2f(deltaY, deltaX);
}

-(CGFloat) angleBetween:(CGPoint)point1 from:(CGPoint)point2 {
	CGFloat deltaX = point2.x - point1.x;
	CGFloat deltaY = point2.y - point1.y;
	return atan2f(deltaY, deltaX) - (90 * _degreesToRadiansConversionFactor);
}

#pragma mark COORDINATE CONVERSIONS


//OSX uses NSPoint and iOS uses CGPoint
-(CGPoint) getCGPointFromString:(NSString*)string {
	CGPoint point;
	
#if TARGET_OS_IPHONE
	point = CGPointFromString(string);
#else
	point = NSPointFromString(string);
#endif
	return point;
}


//another OSX vs iOS variation
-(NSString*)getStringFromPoint:(CGPoint)location {
	NSString* string;
	
#if TARGET_OS_IPHONE
	string = NSStringFromCGPoint(location);
#else
	string = NSStringFromPoint(location);
#endif
	return string;
	
}

#pragma mark TIME HANDLERS

-(void)updateCurrentTime:(CFTimeInterval)timeUpdate {
	
	_previousFrameDuration = timeUpdate - _currentTime;
	_currentTime = timeUpdate;

}


@end
