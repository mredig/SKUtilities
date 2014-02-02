//
//  SGG_SKUtilities.m
//  Schmup
//
//  Created by Michael Redig on 1/1/14.
//  Copyright (c) 2014 Michael Redig. All rights reserved.
//
// version 1.1

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
-(CGFloat)distanceBetween:(CGPoint)pointA and: (CGPoint)pointB {
//	return hypotf(pointB.x - pointA.x, pointB.y - pointA.y); //faster
//	return hypot(pointB.x - pointA.x, pointB.y - pointA.y); //fast
//	return sqrt(pow(pointB.x-pointA.x,2)+pow(pointB.y-pointA.y,2)); //unfast
	return sqrt((pointB.x - pointA.x) * (pointB.x - pointA.x) + (pointB.y - pointA.y) * (pointB.y - pointA.y)); //fastest
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

#pragma mark VECTOR UTILTIES

-(CGVector)normalizeVector:(CGVector)vector {
	CGVector normal;
	
//	CGFloat distance = hypotf(vector.dx, vector.dy);
	CGFloat distance = sqrt(vector.dx * vector.dx + vector.dy * vector.dy); //this function is faster!
	
	normal = CGVectorMake(vector.dx / distance, vector.dy / distance);
	return normal;
}

-(CGVector)addVectorA:(CGVector)vectorA toVectorB:(CGVector)vectorB andNormalize:(BOOL)normalize {
	
	CGVector addedVector;
	addedVector = CGVectorMake(vectorA.dx + vectorB.dx, vectorA.dy + vectorB.dy);
	
	if (normalize) {
		addedVector = [self normalizeVector:addedVector];
	}

	return addedVector;
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

-(NSDictionary*)calculateDurationsFromSeconds:(CFTimeInterval)seconds {
	
	//declarations
	CGFloat leftOverSeconds;
	CGFloat minutes;
	CGFloat hours;
	CGFloat days;
	CGFloat weeks;
	
	//calculations
	leftOverSeconds = seconds;
	minutes = seconds / 60.0f;
	hours = minutes / 60.0f;
	days = hours / 24.0f;
	weeks = days / 7.0f;
	
	//return dict
	NSDictionary* outputDict = [NSDictionary dictionaryWithObjectsAndKeys:
								[NSNumber numberWithFloat:leftOverSeconds], @"seconds",
								[NSNumber numberWithFloat:minutes], @"minutes",
								[NSNumber numberWithFloat:hours], @"hours",
								[NSNumber numberWithFloat:days], @"days",
								[NSNumber numberWithFloat:weeks], @"weeks",
								nil];
	
	return  outputDict;
}

-(NSDictionary*)parseDurationsFromSeconds:(CFTimeInterval)seconds {
	
	//declarations
	CGFloat leftOverSeconds;
	CGFloat minutes;
	CGFloat hours;
	CGFloat days;
	CGFloat weeks;
	
	//calculations
//	leftOverSeconds = seconds;
	
//	minutes = seconds / 60.0f;
//	hours = minutes / 60.0f;
//	days = hours / 24.0f;
	weeks = fmod(seconds, 604800);
	
	//return dict
	NSDictionary* outputDict = [NSDictionary dictionaryWithObjectsAndKeys:
								[NSNumber numberWithFloat:leftOverSeconds], @"seconds",
								[NSNumber numberWithFloat:minutes], @"minutes",
								[NSNumber numberWithFloat:hours], @"hours",
								[NSNumber numberWithFloat:days], @"days",
								[NSNumber numberWithFloat:weeks], @"weeks",
								nil];
	
	return  outputDict;
	
}

@end
