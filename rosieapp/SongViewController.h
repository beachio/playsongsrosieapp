//
//  SongViewController.h
//  rosieapp
//
//  Created by Bala Bhadra Maharjan on 6/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

#define SONG_NUMBER 18

@interface SongViewController : UIViewController <AVAudioPlayerDelegate>{
	IBOutlet UISlider *progressView;
	AVAudioPlayer *player;
	NSTimer	*updateTimer;
	BOOL inBackground;
	NSInteger index;
    IBOutlet UIImageView *headlight;
    NSTimer *blinker;
    NSInteger blinkCount;
}


-(id)initWithIndex:(NSInteger)anIndex;
-(void)updateCurrentTime;
-(void)registerForBackgroundNotifications;
-(void)playSong:(NSInteger)anIndex;

-(IBAction)play:(id)sender;
-(IBAction)pause:(id)sender;
-(IBAction)previous:(id)sender;
-(IBAction)next:(id)sender;
-(IBAction)stop:(id)sender;
-(IBAction)progressSliderMoved:(UISlider*)sender;
-(IBAction)back;
-(IBAction)carPressed:(id)sender;

@property (nonatomic, retain) AVAudioPlayer *player;
@property (nonatomic, retain) NSTimer *updateTimer;
@property (nonatomic, assign) BOOL inBackground;
@property (nonatomic, assign) NSInteger index;


@end
