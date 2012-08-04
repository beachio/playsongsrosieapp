//
//  SongViewController.h
//  rosieapp
//
//  Created by Bala Bhadra Maharjan on 6/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "MHRotaryKnob.h"

#define SONG_NUMBER 18

@interface SongViewController : UIViewController <AVAudioPlayerDelegate, UIGestureRecognizerDelegate>{
	IBOutlet UISlider *progressView;
	AVAudioPlayer *player;
	NSTimer	*updateTimer;
	BOOL inBackground;
	NSInteger index;
    IBOutlet UIImageView *headlight;
    NSTimer *blinker;
    NSInteger blinkCount;
    AVAudioPlayer *honk;
    IBOutlet UIView *lockControl;
    BOOL shuffle;
    BOOL loop;
    IBOutlet UILabel *trackNumber;
    CGFloat volume;
    NSMutableArray *shuffledSongs;
    NSInteger shuffleIndex;
    IBOutlet UIButton *loopButton;
    IBOutlet UIButton *shuffleButton;
    IBOutlet UIButton *prevButton;
    IBOutlet UIButton *nextButton;
    IBOutlet MHRotaryKnob *rotaryKnob;
    
    IBOutlet UIButton *controlSlide;
    IBOutlet UIButton *backButton;
    
    CGRect origControlFrame;
    
}


-(id)initWithIndex:(NSInteger)anIndex;
-(void)updateCurrentTime;
-(void)registerForBackgroundNotifications;
-(void)playSong:(NSInteger)anIndex;

-(IBAction)play:(id)sender;
-(IBAction)pause:(id)sender;
-(IBAction)previous:(id)sender;
-(IBAction)next:(id)sender;
-(IBAction)progressSliderMoved:(UISlider*)sender;
-(IBAction)back;
-(IBAction)carPressed:(id)sender;
-(IBAction)shuffle:(id)sender;
-(IBAction)loop:(id)sender;


@property (nonatomic, retain) AVAudioPlayer *player;
@property (nonatomic, retain) NSTimer *updateTimer;
@property (nonatomic, assign) BOOL inBackground;
@property (nonatomic, assign) NSInteger index;


@end
