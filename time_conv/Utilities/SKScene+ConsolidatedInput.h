//
//  SKUScene.h
//  SGG_SKUtilities
//
//  Created by Michael Redig on 3/11/14.
//  Copyright (c) 2014 Michael Redig. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SKView+AdditionalMouseSupport.h"

@interface SKScene (ConsolidatedInput)

-(void)inputBegan:(CGPoint)location withEventDictionary:(NSDictionary*)eventDict ;
-(void)inputMoved:(CGPoint)location withEventDictionary:(NSDictionary*)eventDict ;
-(void)inputEnded:(CGPoint)location withEventDictionary:(NSDictionary*)eventDict ;


@end
