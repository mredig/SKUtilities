//
//  SGG_SKUtilities.h
//
//  Created by Michael Redig on 1/1/14.
//  Copyright (c) 2014 Michael Redig. All rights reserved.
//
// version 1.1

//#import "TestFlight.h"



#import "SKUtilityConstants.h"

@interface SGG_SKUtilities : NSObject


@property (nonatomic, readonly) CGFloat radiansToDegreesConversionFactor;
@property (nonatomic, readonly) CGFloat degreesToRadiansConversionFactor;


@property (nonatomic, readonly) CFTimeInterval currentTime;
@property (nonatomic, readonly) CFTimeInterval previousFrameDuration;





+(SGG_SKUtilities*) sharedUtilities;

-(CGFloat)distanceBetween:(CGPoint)pointA and: (CGPoint)pointB;
-(BOOL)distanceBetweenPointA:(CGPoint)pointA andPointB:(CGPoint)pointB isWithinXDistance:(CGFloat)distance;
-(BOOL)distanceBetweenPointA:(CGPoint)pointA andPointB:(CGPoint)pointB isWithinXDistancePreSquared:(CGFloat)distanceSquared;
-(CGFloat) orientTo:(CGPoint)point1 from:(CGPoint)point2;
-(CGFloat) angleBetween:(CGPoint)point1 from:(CGPoint)point2;
-(CGPoint) getCGPointFromString:(NSString*)string;
-(NSString*)getStringFromPoint:(CGPoint)location;

-(void)updateCurrentTime:(CFTimeInterval)timeUpdate; //call this from the update method in the current scene

-(NSDictionary*)calculateDurationsFromSeconds:(CFTimeInterval)seconds;
-(NSDictionary*)parseDurationsFromSeconds:(CFTimeInterval)seconds;


//vectors
-(CGVector)vectorFromCGPoint:(CGPoint)point;
-(CGVector)vectorNormalize:(CGVector)vector;
-(CGVector)vectorAddA:(CGVector)vectorA toVectorB:(CGVector)vectorB andNormalize:(BOOL)normalize;
-(CGVector)vectorSubtractA:(CGVector)vectorA fromVectorB:(CGVector)vectorB andNormalize:(BOOL)normalize;
-(CGVector)vectorFacingPoint:(CGPoint)destination fromPoint:(CGPoint)origin andNormalize:(BOOL)normalize;


//points
-(CGPoint)pointFromCGVector:(CGVector)vector;
-(CGPoint)pointAddA:(CGPoint)pointA toPointB:(CGPoint)pointB;
-(CGPoint)pointStepFromPoint:(CGPoint)origin withVector:(CGVector)vector vectorIsNormal:(BOOL)vectorIsNormal withFrameInterval:(CFTimeInterval)interval andMaxInterval:(CGFloat)maxInterval withSpeed:(CGFloat)speed andSpeedModifiers:(CGFloat)speedModifiers;
-(CGPoint)pointStepFromPoint:(CGPoint)origin towardsPoint:(CGPoint)destination withFrameInterval:(CFTimeInterval)interval andMaxInterval:(CGFloat)maxInterval withSpeed:(CGFloat)speed andSpeedModifiers:(CGFloat)speedModifiers;


@end
