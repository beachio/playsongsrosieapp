//
//  SoundHelper.h
//  Calculator
//
//  Created by Bala Bhadra Maharjan on 8/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface SoundHelper : NSObject {
	AVAudioPlayer *audioPlayer;
}

@property (nonatomic, retain) AVAudioPlayer *audioPlayer;

-(void)playAudio:(NSString *)audioFile;
-(void)initializeAudioPlayer;
-(void)stop;

@end
