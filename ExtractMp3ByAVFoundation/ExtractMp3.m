//
//  ExtractMp3.m
//  ExtractMp3ByAVFoundation
//
//  Created by Arthur on 13-1-23.
//  Copyright (c) 2013年 sj. All rights reserved.
//

#import "ExtractMp3.h"


@implementation ExtractMp3
@synthesize pictureView = _111pictureView;
@synthesize currentPoint;

- (void)awakeFromNib
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mediaProgressValueDidChange:) name:MediaProgressBarValueDidChangeNotify object:nil];
}

- (void)openPanelDidEnd:(id)panel returnCode:(NSInteger)code contextInfo:(void *)userInfo
{
    if (code == NSAlertDefaultReturn)
    {
        [textFieldPath setStringValue:[panel filename]];
        selectMusicUrl = [NSURL fileURLWithPath:[panel filename]];
        [selectMusicUrl retain];
        
        
        AVURLAsset *avURLAsset = [AVURLAsset URLAssetWithURL:selectMusicUrl options:nil];
        NSString *mp3FilePath = [[[avURLAsset URL]absoluteString]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *musicTitle = [mp3FilePath lastPathComponent];
        NSLog(@"musicTitle = %@",musicTitle);
        
        musicTitle = [musicTitle substringToIndex:[musicTitle rangeOfString:@"."].location];
        
        NSLog(@"duration = %0.1f",CMTimeGetSeconds(avURLAsset.duration));
        
        [textFieldDuration setStringValue:[NSString stringWithFormat:@"%0.1f second",CMTimeGetSeconds(avURLAsset.duration)]];
        duration = (NSUInteger)CMTimeGetSeconds(avURLAsset.duration);
        NSLog(@"selectMusicUrl = %@",selectMusicUrl);
        
        [_111pictureView setImage:nil];
        
        for (NSString *format in [avURLAsset availableMetadataFormats])
        {
            NSLog(@"-------format:%@",format);
            for (AVMetadataItem *metadataItem in [avURLAsset metadataForFormat:format])
            {
                //NSLog(@"commonKey:%@ value:%@",metadataItem.commonKey,metadataItem.value);
                if ([metadataItem.commonKey isEqualToString:@"artwork"])
                {
                    //取出封面artwork，从data转成image显示
                    NSData *data = (NSData *)[(NSDictionary*)metadataItem.value objectForKey:@"data"];
                    NSImage *img = [[NSImage alloc ]initWithData:data];
                    [_111pictureView setImage:img];
                    [img release];
                }
                if([metadataItem.commonKey isEqualToString:@"title"])
                {
                    [textFieldTitle setStringValue:(NSString*)metadataItem.value];
                }
                if([metadataItem.commonKey isEqualToString:@"albumName"])
                {
                    [textFieldAlbum setStringValue:(NSString*)metadataItem.value];
                }
                if([metadataItem.commonKey isEqualToString:@"artist"])
                {
                    [textFieldArtist setStringValue:(NSString*)metadataItem.value];
                }
            }
            
        }
        if(audioPlayer)
        {
            [audioPlayer stop];
            [audioPlayer release];
        }
        audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:selectMusicUrl error:NULL];
        [audioPlayer play];
        playAndPuaseButton.title = @"pause";
        
        [NSTimer scheduledTimerWithTimeInterval: 0.1f
                                         target:self
                                       selector:@selector(getSoundPoint:)
                                       userInfo:self
                                        repeats:YES];
        
	}
}

- (IBAction)browser:(id)sender
{
    NSOpenPanel *panel =  [NSOpenPanel openPanel];
	[panel setCanChooseDirectories:NO];
    NSString *musicPath = [NSHomeDirectory() stringByAppendingPathComponent:  @"Music"];
    NSArray *allowType = [NSArray arrayWithObjects:@"mp3",nil];
    
    [panel beginSheetForDirectory:musicPath
                             file:nil
                            types:allowType
                   modalForWindow:[sender window]
                    modalDelegate:self
                   didEndSelector:@selector(openPanelDidEnd:returnCode:contextInfo:)
                      contextInfo:NULL];
}

- (void)getSoundPoint:(id)obj
{
    [self willChangeValueForKey:@"currentPoint"];
    currentPoint = (audioPlayer.currentTime/duration)*100;
    [self didChangeValueForKey:@"currentPoint"];
}

- (IBAction)play:(id)sender
{
    if(audioPlayer)
    {
        if([audioPlayer isPlaying])
        {
            [audioPlayer pause];
            playAndPuaseButton.title = @"play";
        }
        else
        {
            [audioPlayer play];
            playAndPuaseButton.title = @"pause";
            
        }
    }
}

- (void)mediaProgressValueDidChange:(NSNotification *)aNotification
{
    NSLog(@"mediaProgressValueDidChange");
    if(processIndicatior == [aNotification object])
	{
		NSNumber *progress=[[aNotification userInfo] objectForKey:@"ProgressBarValue"];
        [audioPlayer pause];
        double second = ([progress intValue] * duration)/100;
        [audioPlayer setCurrentTime:second];
        
		[audioPlayer play];
	}
}

@end
