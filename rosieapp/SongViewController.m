//
//  SongViewController.m
//  rosieapp
//
//  Created by Bala Bhadra Maharjan on 6/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SongViewController.h"
#import "UIDevice+Hardware.h"

@implementation SongViewController

@synthesize player;
@synthesize updateTimer;
@synthesize inBackground;
@synthesize index;

- (id)initWithIndex:(NSInteger)anIndex
{
    self = [super initWithNibName:@"SongViewController" bundle:nil];
    if (self) {
        self.index = anIndex + 1;
        if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstRun"]) {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstRun"];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"shuffle"];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"loop"];
            [[NSUserDefaults standardUserDefaults] setFloat:1.0f forKey:@"volume"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }

        shuffle = [[NSUserDefaults standardUserDefaults] boolForKey:@"shuffle"];
        loop = [[NSUserDefaults standardUserDefaults] boolForKey:@"loop"];
        volume = [[NSUserDefaults standardUserDefaults] boolForKey:@"volume"];
        shuffledSongs = [NSMutableArray array];
        shuffleIndex = -1;
    }
    return self;
}


- (void)updateViewForPlayerState:(AVAudioPlayer *)p{
	[self updateCurrentTime];
	
	if (updateTimer) 
		[updateTimer invalidate];
	
	if (p.playing)
	{
		updateTimer = [NSTimer scheduledTimerWithTimeInterval:.01 target:self selector:@selector(updateCurrentTime) userInfo:p repeats:YES];
	}
	else
	{
		updateTimer = nil;
	}
	
}

-(void)updateCurrentTime{
	progressView.value = player.currentTime/player.duration;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[self registerForBackgroundNotifications];
	
	[self playSong:index];	
    
    // Setup custom slider images
	UIImage *minImage = [UIImage imageNamed:@"progress_bar.png"];
	UIImage *maxImage = [UIImage imageNamed:@"progress_bar.png"];
	UIImage *tumbImage= [UIImage imageNamed:@"progress_indicator.png"];
	
	minImage=[minImage stretchableImageWithLeftCapWidth:5.0 topCapHeight:0.0];
	maxImage=[maxImage stretchableImageWithLeftCapWidth:5.0 topCapHeight:0.0];
    // Setup the FX slider
	[progressView setMinimumTrackImage:minImage forState:UIControlStateNormal];
	[progressView setMaximumTrackImage:maxImage forState:UIControlStateNormal];
	[progressView setThumbImage:tumbImage forState:UIControlStateNormal];
    
    rotaryKnob.interactionStyle = MHRotaryKnobInteractionStyleRotating;
	rotaryKnob.resetsToDefault = NO;
	rotaryKnob.backgroundColor = [UIColor clearColor];
	[rotaryKnob setKnobImage:[UIImage imageNamed:@"volume_knob.png"] forState:UIControlStateNormal];
	
	[rotaryKnob addTarget:self action:@selector(rotaryKnobDidChange) forControlEvents:UIControlEventValueChanged];
    
    UISwipeGestureRecognizer *recognizer;
    
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:UISwipeGestureRecognizerDirectionUp];
    [recognizer setDelegate:self];
    [[self view] addGestureRecognizer:recognizer];
    
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:UISwipeGestureRecognizerDirectionDown];
    [recognizer setDelegate:self];
    [[self view] addGestureRecognizer:recognizer];

}

// Prevent recognizing touches on the slider
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    if ([touch.view isKindOfClass:[UIButton class]]) {
        return YES;
    }
    return NO;
}

-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer {
    
    if ([recognizer direction] == UISwipeGestureRecognizerDirectionUp) {
        lockControl.hidden = NO;
        backButton.enabled = NO;
        [controlSlide setImage:[UIImage imageNamed:@"lock_on.png"] forState:UIControlStateNormal];
        [controlSlide setImage:[UIImage imageNamed:@"lock_on.png"] forState:UIControlStateHighlighted];
        
    } else {
        lockControl.hidden = YES;
        backButton.enabled = YES;
        [controlSlide setImage:[UIImage imageNamed:@"lock_off.png"] forState:UIControlStateNormal];
        [controlSlide setImage:[UIImage imageNamed:@"lock_off.png"] forState:UIControlStateHighlighted];
    }
}


-(void)rotaryKnobDidChange{
    NSLog(@"%f",volume);
    volume = rotaryKnob.value;
    player.volume = volume;
}

-(void)playSong:(NSInteger)anIndex{
    NSString *songTitle = [NSString stringWithFormat:@"%d Audio Track.mp3", anIndex];
	NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], songTitle]];
	NSError *error;
	self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
	if (self.player == nil){
		NSLog(@"%@",[error localizedDescription]);
	}
	else{
		player.volume = volume;
		player.numberOfLoops = 0;
		player.delegate = self;
		[player prepareToPlay];
		[player play];
		[self updateViewForPlayerState:player];
        
        [trackNumber setText:[NSString stringWithFormat:@"%d",anIndex]];
	}
}


-(void)pausePlaybackForPlayer:(AVAudioPlayer*)p{
	[p pause];
	[self updateViewForPlayerState:p];
}


-(void)startPlaybackForPlayer:(AVAudioPlayer*)p
{
	if ([p play])
	{
		[self updateViewForPlayerState:p];
	}
	else
		NSLog(@"Could not play %@\n", p.url);
}


-(IBAction)play:(id)sender{
	if (!player.playing)
		[self startPlaybackForPlayer: player];
}


-(IBAction)pause:(id)sender{
	if (player.playing)
		[self pausePlaybackForPlayer: player];
}


-(IBAction)previous:(id)sender{
    if (shuffle) {
        if (shuffleIndex > 0) {
            shuffleIndex--;
            index = [(NSNumber *)[shuffledSongs objectAtIndex:shuffleIndex] intValue];
			[self playSong:index];
		}
		else {
            index = abs(arc4random() % SONG_NUMBER)+1;
			[self playSong:index];
            [shuffledSongs insertObject:[NSNumber numberWithInt:index]  atIndex:0];
		}
    }
    else{
        if (index > 1) {
            index--;
            [self playSong:index];
        }
    }
}


-(IBAction)next:(id)sender{
    if (shuffle) {
        shuffleIndex++;
        if (shuffleIndex < [shuffledSongs count]) {
            index = [(NSNumber *)[shuffledSongs objectAtIndex:shuffleIndex] intValue];
			[self playSong:index];
		}
		else {
            index = abs(arc4random() % SONG_NUMBER)+1;
			[self playSong:index];
            [shuffledSongs addObject:[NSNumber numberWithInt:index]];
		}
    }
    else{
        if (index < SONG_NUMBER) {
            index++;
            [self playSong:index];
        }	
    }
}

- (IBAction)progressSliderMoved:(UISlider *)sender{
	player.currentTime = sender.value * player.duration;
	[self updateCurrentTime];
}


#pragma mark background notifications
- (void)registerForBackgroundNotifications
{
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(setInBackgroundFlag)
												 name:UIApplicationWillResignActiveNotification
											   object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(clearInBackgroundFlag)
												 name:UIApplicationWillEnterForegroundNotification
											   object:nil];
}

- (void)setInBackgroundFlag
{
	//inBackground = true;
}

- (void)clearInBackgroundFlag
{
	inBackground = false;
}


#pragma mark AVAudioPlayer delegate methods

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)p successfully:(BOOL)flag
{
	if (flag == NO)
		NSLog(@"Playback finished unsuccessfully");
	
	[p setCurrentTime:0];
	if (inBackground)
	{
		NSLog(@"in bg");
	}
	else
	{
		[self updateViewForPlayerState:p];
	}
    if (shuffle || loop) {
        [self next:nil];
    }
}


- (void)playerDecodeErrorDidOccur:(AVAudioPlayer *)p error:(NSError *)error
{
	NSLog(@"ERROR IN DECODE: %@\n", error); 
}


// we will only get these notifications if playback was interrupted
- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)p
{
	NSLog(@"Interruption begin. Updating UI for new state");
	// the object has already been paused,	we just need to update UI
	if (inBackground)
	{
		NSLog(@"in bg");
	}
	else
	{
		[self updateViewForPlayerState:p];
	}
}

- (void)audioPlayerEndInterruption:(AVAudioPlayer *)p
{
	NSLog(@"Interruption ended. Resuming playback");
	[self startPlaybackForPlayer:p];
}

-(IBAction)carPressed:(id)sender{
    if (blinker.isValid) {
        [blinker invalidate];
        headlight.hidden = YES;
        blinkCount = 0;
    }
    else{
        blinker = [NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(blink) userInfo:nil repeats:YES];
        
        NSString *sound = [NSString stringWithFormat:@"horn.mp3"];
        NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], sound]];
        NSError *error;
        honk = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        
        if (honk == nil){
            NSLog(@"%@",[error localizedDescription]);
        }
        else{
            honk.volume = 1;
            honk.numberOfLoops = 0;
            [honk play];
        }
    }
}

-(void)blink{
    headlight.hidden = !headlight.hidden;
    blinkCount++;
    if (blinkCount == 4) {
        blinkCount = 0;
        [blinker invalidate];
    }
}

-(IBAction)shuffle:(id)sender{
    shuffle = !shuffle;
    if (shuffle) {
        loop = NO;
        [loopButton setImage:[UIImage imageNamed:@"loop_depress.png"] forState:UIControlStateNormal];
        [shuffleButton setImage:[UIImage imageNamed:@"shuffle.png"] forState:UIControlStateNormal];
    }
    else{
        [shuffleButton setImage:[UIImage imageNamed:@"shuffle_depress.png"] forState:UIControlStateNormal];
    }
    [[NSUserDefaults standardUserDefaults] setBool:shuffle forKey:@"shuffle"];
    [[NSUserDefaults standardUserDefaults] setBool:loop forKey:@"loop"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(IBAction)loop:(id)sender{
    loop = !loop;
    if (loop) {
        shuffle = NO;
        shuffleIndex = -1;
        [shuffledSongs removeAllObjects];
        [shuffleButton setImage:[UIImage imageNamed:@"shuffle_depress.png"] forState:UIControlStateNormal];
        [loopButton setImage:[UIImage imageNamed:@"loop.png"] forState:UIControlStateNormal];
    }
    else{
        [loopButton setImage:[UIImage imageNamed:@"loop_depress.png"] forState:UIControlStateNormal];
    }
    [[NSUserDefaults standardUserDefaults] setBool:shuffle forKey:@"shuffle"];
    [[NSUserDefaults standardUserDefaults] setBool:loop forKey:@"loop"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(IBAction)back{
    [player stop];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Overriden to allow any orientation.
	if (![UIDevice isIPad]) {
		return NO;
	}
	if(interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
		return YES;
	else
		return NO;
}

@end
