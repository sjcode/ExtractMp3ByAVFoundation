//
//  ExtractMp3.h
//  ExtractMp3ByAVFoundation
//
//  Created by Arthur on 13-1-23.
//  Copyright (c) 2013年 sj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "MediaProgressBar.h"
@interface ExtractMp3 : NSObject
{
    IBOutlet NSTextField *textFieldPath;
    IBOutlet NSImageView *_111pictureView;
    
    IBOutlet NSTextField *textFieldTitle;
    IBOutlet NSTextField *textFieldAlbum;
    IBOutlet NSTextField *textFieldArtist;
    IBOutlet NSTextField *textFieldDuration;
    
    IBOutlet MediaProgressBar *processIndicatior;
    IBOutlet NSButton *playAndPuaseButton;
    NSURL *selectMusicUrl;
    AVAudioPlayer *audioPlayer;
    NSUInteger duration;
}

@property (nonatomic,retain) NSImageView *pictureView;
@property (nonatomic,assign) NSInteger currentPoint;

- (IBAction)browser:(id)sender;
- (IBAction)play:(id)sender;
@end
