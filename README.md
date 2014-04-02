SKUtilities
===========

Utilities for SpriteKit

Intended to be an easy resource for SpriteKit projects to get quick access to common functions. What's easiest? Manually typing in your distance equation every time, creating your own convenience method, or having it already created for you so all you have to do is call the method and input your coordinates? 

Note: I am a relatively new programmer, so it's entirely possible I haven't made everything in the neatest, tidiest way. I may not have optimized everything to the best it can be. There may be better, or MUCH better ways of doing these things. However, I am creating this because I have found a use for them and figure others may be able to benefit too. Please don't judge! 

Also Note: Master branch is intended to be the latest stable branch. 

Also Also Note: It is possible variable names or method names may change over time to either make more intuitive or be more organized. I apologize for the difficulty this will cause, but in the long run I expect it to work out better. A find/replace will generally get you going.

Usage:
=========

Copy every file inside the Utilities folder to your project. The header file of every class you wish to access the utilties or buttons from should include:

	#import "SGG_SKUtilties.h"
	#import "SGG_SKMasterButton.h"

In every file you want to use the utilities. These are also the only files required to copy to your project.

In the interface section of the file, create a global variable (not sure if that's 100% correct term for Obj C, but you get the idea) as such

	@interface SGG_MyScene() {
		SGG_SKUtilities* sharedUtilities;
	}
	@end
	
In the init statement of your scene, call upon the singleton:

	sharedUtilties = [SGG_SKUtilities sharedUtilities];
	
This must be initialized before you can call any methods or properties of the class.

finally, to access time data globally, add 

	[sharedUtilties updateCurrentTime:currentTime];
	
to your scene's update method

Now you can access time intervals from previous frame and the current game time globally as such:

	sharedData.previousFrameDuration
	sharedData.currentTime
	

You may utilize multi line label nodes with a call such as

	SKUMultiLineLabelNode* multiLineLabel = [SKUMultiLineLabelNode labelNodeWithFontNamed:@"Futura"];
	multiLineLabel.text = @"Turn this skiff around! Absolutely. And we're going to be here every day. I don't care if it takes from now till the end of Shrimpfest. I need a fake passport, preferably to France… I like the way they think."; //bluthipsum.com
	multiLineLabel.paragraphWidth = 500;
	multiLineLabel.position = CGPointMake(self.size.width/2, self.size.height/2);
	[self addChild:multiLineLabel];
		
This functionality was originally sourced from Chris Allwein of Downright Simple(c). Many thanks to him for open sourcing this code!

Additional functionality added also includes the ability to stroke the text with a color of varying widths like so:

	multiLineLabel.strokeWidth = 3;
	multiLineLabel.strokeColor = [SKColor greenColor];
	
This unfortunately only works correctly on OSX currently. Something about applying the attribute for strokeWidth disables the ability to properly generate proper bounds via this function:

	if (_paragraphHeight == 0) {
		_paragraphHeight = self.scene.size.width; // HERE
	}

    CGRect textRect = [text boundingRectWithSize:CGSizeMake(_paragraphWidth, _paragraphHeight)
                                         options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine
                                      attributes:textAttributes
                                         context:nil];
										 
A temporary workaround for iOS is to set multiLineLabel.paragraphHeight with a manual value. To get an appropriate value, you can uncomment this line

	NSLog(@"textRect = %f %f %f %f", textRect.origin.x, textRect.origin.y, textRect.size.width, textRect.size.height);
	
lower in the SKUMultiLineLabelNode.m file. Take the largest height value given there and manually set it.



Note that you may implement tabs and hard returns with

	/t
	/r


SKScene has been modified with categories (see https://developer.apple.com/library/ios/documentation/cocoa/conceptual/ProgrammingWithObjectiveC/CustomizingExistingClasses/CustomizingExistingClasses.html) to consolidate Mac and iOS code. You may now accept input in your scene for either target with the following methods:

	-(void)inputBegan:(CGPoint)location withEventDictionary:(NSDictionary*)eventDict ;
	-(void)inputMoved:(CGPoint)location withEventDictionary:(NSDictionary*)eventDict ;
	-(void)inputEnded:(CGPoint)location withEventDictionary:(NSDictionary*)eventDict ;

The eventDict contains several useful tidbits. The following keys and values correspond:

*	buttonNumber: iOS is always 0, OS X corresponds to mouse button clicked: 0 = left mouse, 1 = right mouse, 2 = middle mouse. More mouse buttons have not been tested, but theoretically they should work.
*	inputIteration: for OS X, this would tell you if it was a single, double, triple, etc click. iOS would be the same, just with taps
*	intervalTime: NSTimeInterval of the system time the event occurred
*	event: OSX "theEvent" NSEvent object from the corresponding mouse method; iOS "event" object from the corresponding touch method
*	touch: iOS only - the UITouch object from the corresponding touch method

	
To get more information on different methods, refer to the header file. You may also see how it was implemented in the scene file (I'm simply using that to test functionality) to get an idea.

If you have anything worthwhile to add, please either email me @secretgamegroup.com (put "michael" first) or, as I'm new to github, there may be some contact method available here.

Documentation wouldn't hurt either. Say a wiki or apple docs? Maybe I'm getting ahead of myself... :D



Requirements:
=========

XCode 5+
SpriteKit project

Target requirements:

iOS 7+
or 
Mac OS X 10.9+ or whatever SpriteKit's requirements are. I'm not 100% sure and I don't care enough to look them up just for this. I'm not your mom.
