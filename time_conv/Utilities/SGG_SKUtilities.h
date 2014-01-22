//
//  SGG_SKUtilities.h
//
//  Created by Michael Redig on 1/1/14.
//  Copyright (c) 2014 Michael Redig. All rights reserved.
//
// version 1.0

//#import "TestFlight.h"



#import "SKUtilityConstants.h"

@interface SGG_SKUtilities : NSObject


@property (nonatomic, assign) CGFloat radiansToDegreesConversionFactor;
@property (nonatomic, assign) CGFloat degreesToRadiansConversionFactor;


@property (nonatomic, readonly) CFTimeInterval currentTime;
@property (nonatomic, readonly) CFTimeInterval previousFrameDuration;





+(SGG_SKUtilities*) sharedUtilities;

-(CGFloat)distanceBetween:(CGPoint)p1 and:(CGPoint)p2;
-(BOOL)distanceBetweenPointA:(CGPoint)pointA andPointB:(CGPoint)pointB isWithinXDistance:(CGFloat)distance;
-(BOOL)distanceBetweenPointA:(CGPoint)pointA andPointB:(CGPoint)pointB isWithinXDistancePreSquared:(CGFloat)distanceSquared;
-(CGFloat) orientTo:(CGPoint)point1 from:(CGPoint)point2;
-(CGFloat) angleBetween:(CGPoint)point1 from:(CGPoint)point2;
-(CGPoint) getCGPointFromString:(NSString*)string;
-(NSString*)getStringFromPoint:(CGPoint)location;
-(void)updateCurrentTime:(CFTimeInterval)timeUpdate; //call this from the update method in the current scene




@end
