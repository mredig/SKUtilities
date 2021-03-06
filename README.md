SKUtilities
===========

Utilities for SpriteKit

Intended to be an easy resource for SpriteKit projects to get quick access to common functions. What's easiest? Manually typing in your distance equation every time, creating your own convenience method, or having it already created for you so all you have to do is call the method and input your coordinates? 

Note: I am a relatively new programmer, so it's entirely possible I haven't made everything in the neatest, tidiest way. I may not have optimized everything to the best it can be. There may be better, or MUCH better ways of doing these things. However, I am creating this because I have found a use for them and figure others may be able to benefit too. Please don't judge! 

Also Note: Master branch is intended to be the latest stable branch. 

Also Also Note: It is possible variable names or method names may change over time to either make more intuitive or be more organized. I apologize for the difficulty this will cause, but in the long run I expect it to work out better. A find/replace will generally get you going.

Usage:
=========

Include

	SKUtilityConstants.h
	SGG_SKUtilities.h
	SGG_SKUtilities.m

In every file you want to use the utilities.

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
