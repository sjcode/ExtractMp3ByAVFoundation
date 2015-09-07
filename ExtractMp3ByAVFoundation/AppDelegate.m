//
//  AppDelegate.m
//  ExtractMp3ByAVFoundation
//
//  Created by Arthur on 13-1-23.
//  Copyright (c) 2013年 sj. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)dealloc
{
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

- (BOOL)windowShouldClose:(id)sender	//close box quits the app
{
    [NSApp terminate:self];
    return YES;
}

@end
