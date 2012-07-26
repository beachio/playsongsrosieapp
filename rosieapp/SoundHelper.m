//
//  SoundHelper.m
//  Calculator
//
//  Created by Bala Bhadra Maharjan on 8/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SoundHelper.h"

@implementation SoundHelper

@synthesize audioPlayer;

-(void)playAudio:(NSString *)audioFile{
	NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], audioFile]];
	
	NSError *error;
	self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
	audioPlayer.numberOfLoops = 0;
	
	if (audioPlayer == nil){
		NSLog(@"%@",[error description]);
	}
	else{
		[audioPlayer play];
	}
}

-(void)stop{
    [audioPlayer stop];
}

//Call this to avoid delay on first audio play.
-(void)initializeAudioPlayer {
	NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"bleat1.mp3"]];
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [player prepareToPlay];

}

@end
