//
//  MediaProgressBar.m
//  ExtractMp3ByAVFoundation
//
//  Created by Arthur on 13-1-24.
//  Copyright (c) 2013年 sj. All rights reserved.
//

#import "MediaProgressBar.h"
NSString * MediaProgressBarValueDidChangeNotify = @"MediaProgressBarValueDidChange";

@implementation MediaProgressBar

- (void)awakeFromNib
{
    lastpostdate=[[NSDate date] retain];
}

- (void)mouseDown:(NSEvent *)theEvent
{
    isKnobRelease = NO;
	isMouseEnter = YES;
	NSPoint thePoint = [self convertPoint:[theEvent locationInWindow] fromView:nil];
	if(NSPointInRect(thePoint, [self bounds])){
		isMouseDown=YES;
		[self mouseDragged:theEvent];
	}
}

- (void)mouseUp:(NSEvent *)theEvent
{
    isMouseDown=NO;
	isKnobRelease = YES;
	isMouseEnter = NO;
    
	[self setNeedsDisplay:YES];
}

- (void)mouseDragged:(NSEvent *)theEvent
{
	if (isMouseDown)
    {
		NSPoint thePoint = [self convertPoint:[theEvent locationInWindow] fromView:nil];
		double theValue;
		double maxX=[self bounds].size.width;
		
		if (thePoint.x < 0)
			theValue = [self minValue];
		else if (thePoint.x >= [self bounds].size.width)
			theValue = [self maxValue];
		else
			theValue = [self minValue] + (([self maxValue] - [self minValue]) *
										  (thePoint.x - 0) / (maxX - 0));
		[self setDoubleValue:theValue];
		
		NSDate *now=[[NSDate date] retain];
		NSTimeInterval diff = [now timeIntervalSinceDate:lastpostdate];
		if (diff>0.08)
        {
			[[NSNotificationCenter defaultCenter]
			 postNotificationName:MediaProgressBarValueDidChangeNotify
			 object:self
			 userInfo:[NSDictionary
					   dictionaryWithObject:[NSNumber numberWithDouble:theValue]
					   forKey:@"ProgressBarValue"]];
			[lastpostdate release];
			lastpostdate=now;
		}
		
		[self display];
	}
}

@end
