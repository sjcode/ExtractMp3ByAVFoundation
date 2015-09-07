//
//  MediaProgressBar.h
//  ExtractMp3ByAVFoundation
//
//  Created by Arthur on 13-1-24.
//  Copyright (c) 2013年 sj. All rights reserved.
//

#import <Cocoa/Cocoa.h>
APPKIT_EXTERN NSString * MediaProgressBarValueDidChangeNotify;
@interface MediaProgressBar : NSProgressIndicator
{
    BOOL isMouseDown;
	BOOL isMouseEnter;
	BOOL isKnobRelease;
    NSDate	*lastpostdate;
}
@end
