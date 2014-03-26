//
//  SKView+AdditionalMouseSupport.m
//  SGG_SKUtilities
//
//  Created by Michael Redig on 3/11/14.
//  Copyright (c) 2014 Michael Redig. All rights reserved.
//

#import "SKView+AdditionalMouseSupport.h"

@implementation SKView (AdditionalMouseSupport)

#if TARGET_OS_IPHONE
#else
//http://opensource.apple.com/source/CarbonHeaders/CarbonHeaders-18.1/TargetConditionals.h

-(void)rightMouseDown:(NSEvent *)theEvent {
	[self.scene rightMouseDown:theEvent];
}

-(void)rightMouseDragged:(NSEvent *)theEvent {
	[self.scene rightMouseDragged:theEvent];
}

-(void)rightMouseUp:(NSEvent *)theEvent {
	[self.scene rightMouseUp:theEvent];
}

-(void)otherMouseDown:(NSEvent *)theEvent {
	[self.scene otherMouseDown:theEvent];
}

-(void)otherMouseDragged:(NSEvent *)theEvent {
	[self.scene otherMouseDragged:theEvent];
}

-(void)otherMouseUp:(NSEvent *)theEvent {
	[self.scene otherMouseUp:theEvent];
}

#endif

@end
