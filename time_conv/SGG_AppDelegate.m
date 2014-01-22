//
//  SGG_AppDelegate.m
//  time_conv
//
//  Created by Michael Redig on 1/22/14.
//  Copyright (c) 2014 Michael Redig. All rights reserved.
//

#import "SGG_AppDelegate.h"
#import "SGG_MyScene.h"

@implementation SGG_AppDelegate

@synthesize window = _window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    /* Pick a size for the scene */
    SKScene *scene = [SGG_MyScene sceneWithSize:CGSizeMake(1024, 768)];

    /* Set the scale mode to scale to fit the window */
    scene.scaleMode = SKSceneScaleModeAspectFit;

    [self.skView presentScene:scene];

    self.skView.showsFPS = YES;
    self.skView.showsNodeCount = YES;
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return YES;
}

@end
