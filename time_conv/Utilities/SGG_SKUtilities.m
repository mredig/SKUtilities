//
//  SGG_SKUtilities.m
//  Schmup
//
//  Created by Michael Redig on 1/1/14.
//  Copyright (c) 2014 Michael Redig. All rights reserved.
//

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
	
//	_radiansToDegreesConversionFactor = (180 / M_PI);
//	_degreesToRadiansConversionFactor = (M_PI / 180);
	
	_deltaMaxTime = 1.0f;
}

#pragma mark RANDOM NUMBERS

-(u_int32_t)randomIntegerBetweenLowEnd:(u_int32_t)lowend andHighEnd:(u_int32_t)highend {
	
	u_int32_t range = highend - lowend;
	u_int32_t random = arc4random_uniform(range);
	random += lowend;
	
	return random;
}

-(CGFloat)randomFloatBetweenZeroAndHighEnd:(CGFloat)highend {
	
	CGFloat floatRange = highend * 1000;
	u_int32_t intRange = floatRange;
	u_int32_t random = arc4random_uniform(intRange);
	CGFloat floatRandom = (CGFloat)random / 1000.0f;

	return floatRandom;
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
	return atan2f(deltaY, deltaX) - (90 * kDegToRadConvFactor_SKUTIL);
}

#pragma mark CGVector HELPERS

-(CGVector)vectorFromCGPoint:(CGPoint)point {
	return CGVectorMake(point.x, point.y);
}

-(CGVector)vectorInverse:(CGVector)vector {
	return CGVectorMake(-vector.dx, -vector.dy);
}

-(CGVector)vectorNormalize:(CGVector)vector {
	CGVector normal;
	
//	CGFloat distance = hypotf(vector.dx, vector.dy);
	CGFloat distance = sqrt(vector.dx * vector.dx + vector.dy * vector.dy); //this function is faster!
	
	normal = CGVectorMake(vector.dx / distance, vector.dy / distance);
	return normal;
}

-(CGVector)vectorAddA:(CGVector)vectorA toVectorB:(CGVector)vectorB andNormalize:(BOOL)normalize {
	
	CGVector addedVector;
	addedVector = CGVectorMake(vectorA.dx + vectorB.dx, vectorA.dy + vectorB.dy);
	
	if (normalize) {
		addedVector = [self vectorNormalize:addedVector];
	}

	return addedVector;
}

-(CGVector)vectorSubtractA:(CGVector)vectorA fromVectorB:(CGVector)vectorB andNormalize:(BOOL)normalize {
	CGVector subtractedVector;
	
	subtractedVector = CGVectorMake(vectorB.dx - vectorA.dx, vectorB.dy - vectorA.dy);
	
	if (normalize) {
		subtractedVector = [self vectorNormalize:subtractedVector];
	}
	
	return subtractedVector;
}

-(CGVector)vectorMultiply:(CGVector)vector by:(CGFloat)multiply {
	
	CGVector multVector;
	multVector = CGVectorMake(vector.dx * multiply, vector.dy * multiply);
	
	return multVector;
}


-(CGVector)vectorFacingPoint:(CGPoint)destination fromPoint:(CGPoint)origin andNormalize:(BOOL)normalize {
	
	CGVector destinationVec = [self vectorFromCGPoint:destination];
	CGVector originVec = [self vectorFromCGPoint:origin];
	
	CGVector directionVector = [self vectorSubtractA:originVec fromVectorB:destinationVec andNormalize:normalize];
	
	return directionVector;
}

-(CGVector)vectorFromRadianAngle:(CGFloat)angle {
	return CGVectorMake(-sinf(angle),cosf(angle));
}

-(CGVector)vectorFromDegreeAngle:(CGFloat)degrees {
	CGFloat angle = degrees * kDegToRadConvFactor_SKUTIL;
	return CGVectorMake(-sinf(angle),cosf(angle));
}



#pragma mark CGPoint HELPERS

-(CGPoint)pointFromCGVector:(CGVector)vector {
	return CGPointMake(vector.dx, vector.dy);
}

-(CGPoint)pointInverse:(CGPoint)point {
	return CGPointMake(-point.x, -point.y);
}

-(CGPoint)pointAddA:(CGPoint)pointA toPointB:(CGPoint)pointB {
	return CGPointMake(pointA.x + pointB.x, pointA.y + pointB.y);
}

-(CGPoint)pointAddValue:(CGFloat)value toPoint:(CGPoint)point {
	return CGPointMake(point.x + value, point.y + value);
}

-(CGPoint)pointStepFromPoint:(CGPoint)origin withVector:(CGVector)vector vectorIsNormal:(BOOL)vectorIsNormal withFrameInterval:(CFTimeInterval)interval andMaxInterval:(CGFloat)maxInterval withSpeed:(CGFloat)speed andSpeedModifiers:(CGFloat)speedModifiers {
	
	if (interval == 0) {
		interval = _deltaFrameTime;
		if (_deltaFrameTime == 0) {
			NSLog(@"Please either set the interval in the point step call, or properly set \"updateCurrentTime\" in your update method.");
		}
	}
	if (maxInterval == 0) {
		maxInterval = 0.05;
	}
	if (interval > maxInterval) {
		interval = maxInterval;
	}
	
	CGFloat adjustedSpeed = speed * speedModifiers * interval;
	
	
	CGVector normalVec = vector;
	if (!vectorIsNormal) {
		normalVec = [self vectorNormalize:normalVec];
	}
	
	CGPoint destination = CGPointMake(origin.x + normalVec.dx * adjustedSpeed,
								origin.y + normalVec.dy * adjustedSpeed);

	
	return destination;
}

-(CGPoint)pointStepFromPoint:(CGPoint)origin towardsPoint:(CGPoint)destination withFrameInterval:(CFTimeInterval)interval andMaxInterval:(CGFloat)maxInterval withSpeed:(CGFloat)speed andSpeedModifiers:(CGFloat)speedModifiers {

	if (interval == 0) {
		interval = _deltaFrameTime;
		if (_deltaFrameTime == 0) {
			NSLog(@"Please either set the interval in the point step call, or properly set \"updateCurrentTime\" in your update method.");
		}
	}
	if (maxInterval == 0) {
		maxInterval = 0.05;
	}
	if (interval > maxInterval) {
		interval = maxInterval;
	}
	
	CGFloat adjustedSpeed = speed * speedModifiers * interval;
	
	CGVector vectorBetweenPoints = [self vectorFacingPoint:destination fromPoint:origin andNormalize:YES];
	
	CGPoint newDestination = CGPointMake(origin.x + vectorBetweenPoints.dx * adjustedSpeed,
									  origin.y + vectorBetweenPoints.dy * adjustedSpeed);
	return newDestination;
}

-(CGPoint)pointBFromPointA:(CGPoint)pointA withVector:(CGVector)vector vectorIsNormalized:(BOOL)normalized andDistance:(CGFloat)distance {
	
	if (!normalized) {
		vector = [self vectorNormalize:vector];
	}
	
	vector = [self vectorMultiply:vector by:distance];
	CGPoint pointB = CGPointMake(vector.dx + pointA.x, vector.dy + pointA.y);
	
	return pointB;
}

-(BOOL)nodeAtPoint:(CGPoint)originPos isBehindNodeAtPoint:(CGPoint)victimPos facingVector:(CGVector)victimFacingVector isVectorNormal:(BOOL)victimFacingVectorNormal withLatitudeOf:(CGFloat)latitude andMaximumDistanceBetweenPoints:(CGFloat)maxDistance{
	
	
	bool anglesMatch = [self nodeAtPoint:originPos isBehindNodeAtPoint:victimPos facingVector:victimFacingVector isVectorNormal:victimFacingVectorNormal withLatitudeOf:latitude];
	
	//check if angles match up
	if (anglesMatch) {
		//only calculate distance if we know the angles work for a backstab
		if ([self distanceBetweenPointA:originPos andPointB:victimPos isWithinXDistance:maxDistance]) {
			return YES; //distance is within range
		} else {
			return NO; //distance is not within range
		}
	} else {
		return NO; //angles dont match
	}
}

-(BOOL)nodeAtPoint:(CGPoint)originPos isBehindNodeAtPoint:(CGPoint)victimPos facingVector:(CGVector)victimFacingVector isVectorNormal:(BOOL)victimFacingVectorNormal withLatitudeOf:(CGFloat)latitude {
	CGVector normalOriginFacingVector, normalVictimFacingVector;
	
	normalOriginFacingVector = [self vectorFacingPoint:originPos fromPoint:victimPos andNormalize:YES];
	
	//normalize victim vector if necessary
	if (victimFacingVectorNormal) {
		normalVictimFacingVector = victimFacingVector;
	} else {
		normalVictimFacingVector = [self vectorNormalize:victimFacingVector];
	}
	
	//calculate dotProduct
	//values > 0 means murderer is infront of victim, value == 0 means murderer is DIRECTLY beside victim (left OR right), value < 0 means murderer is behind victim, -1 is EXACTLY DIRECTLY behind victim. Range of -1 to 1;
	//see http://www.youtube.com/watch?v=Q9FZllr6-wY for more info
	
	CGFloat dotProduct = normalOriginFacingVector.dx * normalVictimFacingVector.dx + normalOriginFacingVector.dy * normalVictimFacingVector.dy;
	
	
	//check if angles match up
	if (dotProduct < -latitude) {
		return YES; //angles match
	} else {
		return NO; //angles dont match
	}
}

-(CGPoint)linearInterpolationBetweenPointA:(CGPoint)a andPointB:(CGPoint)b andPlaceBetween:(CGFloat)t {	
	return CGPointMake(a.x + (b.x-a.x)*t, a.y + (b.y-a.y)*t);
}

-(NSValue*)valueObjectFromPoint:(CGPoint)point {
#if TARGET_OS_IPHONE
	return [NSValue valueWithCGPoint:point];
#else
	return [NSValue valueWithPoint:point];
#endif
	
}

-(CGPoint)pointFromValueObject:(NSValue*)valueObject {
#if TARGET_OS_IPHONE
	return [valueObject CGPointValue];
#else
	return [valueObject pointValue];
#endif
	
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
	
	_deltaFrameTimeUncapped = timeUpdate - _currentTime;
	
	if (_deltaFrameTimeUncapped > _deltaMaxTime) {
		_deltaFrameTime = _deltaMaxTime;
	} else {
		_deltaFrameTime = _deltaFrameTimeUncapped;
	}
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
	
//	//declarations
//	CGFloat leftOverSeconds;
//	CGFloat minutes;
//	CGFloat hours;
//	CGFloat days;
//	CGFloat weeks;
//	
//	//calculations
////	leftOverSeconds = seconds;
//	
////	minutes = seconds / 60.0f;
////	hours = minutes / 60.0f;
////	days = hours / 24.0f;
//	weeks = fmod(seconds, 604800);
//	
//	//return dict
//	NSDictionary* outputDict = [NSDictionary dictionaryWithObjectsAndKeys:
//								[NSNumber numberWithFloat:leftOverSeconds], @"seconds",
//								[NSNumber numberWithFloat:minutes], @"minutes",
//								[NSNumber numberWithFloat:hours], @"hours",
//								[NSNumber numberWithFloat:days], @"days",
//								[NSNumber numberWithFloat:weeks], @"weeks",
//								nil];
	NSDictionary* outputDict;
	
	return  outputDict;
	
}
	
#pragma mark MISC
-(CGFloat)rampToValue:(CGFloat)idealValue fromCurrentValue:(CGFloat)currentValue withRampStep:(CGFloat)step {
	
	//check that step is valid
	if (step < 0) {
		step = -step;
	} else if (step == 0) {
		NSLog(@"uh, you need to assign a step value for a ramp to work!");
	}
	
	//apply the step
	CGFloat newValue;
	if (currentValue < idealValue) {
		newValue = currentValue + step;
	} else if (currentValue > idealValue) {
		newValue = currentValue - step;
	} else {
		newValue = idealValue;
	}
	
	//check if you are at your target value
	if (fabs(newValue - idealValue) < step) {
		newValue = idealValue;
	}
	
	
	
	return newValue;
}



#pragma mark NEW



-(CGPoint)findPointOnBezierCurveWithPointA:(CGPoint)a andPointB:(CGPoint)b andPointC:(CGPoint)c andPointD:(CGPoint)d andPlaceOnCurve:(CGFloat)t {
	
	CGPoint ab, bc, cd, abbc, bccd, dest;
//	ab = [self linearInterpolationBetweenPointA:a andPointB:b andPlaceBetween:t];
//	bc = [self linearInterpolationBetweenPointA:b andPointB:c andPlaceBetween:t];
//	cd = [self linearInterpolationBetweenPointA:c andPointB:d andPlaceBetween:t];
//	abbc = [self linearInterpolationBetweenPointA:ab andPointB:bc andPlaceBetween:t];
//	bccd = [self linearInterpolationBetweenPointA:bc andPointB:cd andPlaceBetween:t];
//	dest = [self linearInterpolationBetweenPointA:abbc andPointB:bccd andPlaceBetween:t];
	
	
	ab = CGPointMake(a.x + (b.x-a.x)*t, a.y + (b.y-a.y)*t);
	bc = CGPointMake(b.x + (c.x-b.x)*t, b.y + (c.y-b.y)*t);
	cd = CGPointMake(c.x + (d.x-c.x)*t, c.y + (d.y-c.y)*t);
	abbc = CGPointMake(ab.x + (bc.x-ab.x)*t, ab.y + (bc.y-ab.y)*t);
	bccd = CGPointMake(bc.x + (cd.x-bc.x)*t, bc.y + (cd.y-bc.y)*t);
	dest = CGPointMake(abbc.x + (bccd.x-abbc.x)*t, abbc.y + (bccd.y-abbc.y)*t);

	return dest;
}



-(CGPoint)calculateBezierPoint:(CGFloat)t andPoint0:(CGPoint)p0 andPoint1:(CGPoint)p1 andPoint2:(CGPoint)p2 andPoint3:(CGPoint)p3 {
	
	CGFloat u = 1 - t;
	CGFloat tt = t * t;
	CGFloat uu = u * u;
	CGFloat uuu = uu * u;
	CGFloat ttt = tt * t;
	
	
	CGPoint finalPoint = CGPointMake(p0.x * uuu, p0.y * uuu);
	finalPoint = CGPointMake(finalPoint.x + (3 * uu * t * p1.x), finalPoint.y + (3 * uu * t * p1.y));
	finalPoint = CGPointMake(finalPoint.x + (3 * u * tt * p2.x), finalPoint.y + (3 * u * tt * p2.y));
	finalPoint = CGPointMake(finalPoint.x + (ttt * p3.x), finalPoint.y + (ttt * p3.y));
	
	
	return finalPoint;
}

@end

@implementation SGG_PositionObject

-(id)init {
	if (self = [super init]) {
	
	}
	return self;
}

-(id)initWithPosition:(CGPoint)position {
	if (self = [super init]) {
		self.position = position;
	}
	return self;
}

-(id)initWithVector:(CGVector)vector {
	if (self = [super init]) {
		self.vector = vector;
	}
	return self;
}

-(id)initWithSize:(CGSize)size {
	if (self = [super init]) {
		self.size = size;
	}
	return self;
}

-(id)initWithRect:(CGRect)rect {
	if (self = [super init]) {
		self.rect = rect;
	}
	return self;
}


+(SGG_PositionObject*)position:(CGPoint)location {
	return [[SGG_PositionObject alloc]initWithPosition:location];
}

+(SGG_PositionObject*)vector:(CGVector)vector {
	return [[SGG_PositionObject alloc]initWithVector:vector];
}

+(SGG_PositionObject*)size:(CGSize)size {
	return [[SGG_PositionObject alloc]initWithSize:size];
}

+(SGG_PositionObject*)rect:(CGRect)rect {
	return [[SGG_PositionObject alloc]initWithRect:rect];
}


-(void)setPosition:(CGPoint)position {
	_position = position;
	_vector = CGVectorMake(position.x, position.y);
	_rect = CGRectMake(position.x, position.y, _size.width, _size.height);
}

-(void)setVector:(CGVector)vector {
	_vector = vector;
	_position = CGPointMake(vector.dx, vector.dy);
	_rect = CGRectMake(vector.dx, vector.dy, _size.width, _size.height);

}

-(void)setSize:(CGSize)size {
	_size = size;
	_rect = CGRectMake(_position.x, _position.y, size.width, size.height);
}

-(void)setRect:(CGRect)rect {
	_rect = rect;
	_position = CGPointMake(rect.origin.x, rect.origin.y);
	_vector = CGVectorMake(rect.origin.x, rect.origin.y);
	_size = CGSizeMake(rect.size.width, rect.size.height);
}

-(CGSize)getSizeFromPosition {
	return CGSizeMake(_position.x, _position.y);
}

-(CGPoint)getPositionFromSize {
	return CGPointMake(_size.width, _size.height);
}

-(CGVector)getVectorFromSize {
	return CGVectorMake(_size.width, _size.height);
}

@end

