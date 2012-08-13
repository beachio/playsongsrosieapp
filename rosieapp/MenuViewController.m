//
//  MenuViewController.m
//  rosieapp
//
//  Created by Bala Bhadra Maharjan on 6/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuViewController.h"
#import "SongListViewController.h"
#import "UIDevice+Hardware.h"

static NSString* kAppId = @"428037127238161";

@implementation MenuViewController
@synthesize facebook;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        permissions =  [NSArray arrayWithObjects: @"read_stream", @"publish_stream", @"offline_access",nil];
		facebook = [[Facebook alloc] initWithAppId:kAppId andDelegate:self];
    }
    return self;
}

/**
 * Open an inline dialog that allows the logged in user to publish a story to his or
 * her wall.
 */
- (void)publishStream {
	NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
								   @"http://playsongsplus.com", @"link",
								   @"http://playsongsplus.com/wp-content/uploads/2009/02/rosie-front-small.jpg", @"picture",
								   @"I'm playing with my Rosie - The Little Red Car iOS app", @"name",
								   @"Rosie the Little Red Car contains 18 wonderful original playsongs for under 5's", @"caption",
								   @"By Ruplay.co.uk and Playsongs Plus for iPad and iPhone", @"description",
								   nil];
	
	[facebook dialog:@"feed" andParams:params andDelegate:self];
}

/**
 * Called when an error prevents the Facebook API request from completing
 * successfully.
 */
- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
	[[[UIAlertView alloc] initWithTitle:@"Error" message:[error description] delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil] show];
};


#pragma mark FBSessionDelegate

- (void)fbDidLogin{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:facebook.accessToken forKey:ACCESS_TOKEN_KEY];
	[defaults setObject:facebook.expirationDate forKey:EXPIRATION_DATE_KEY];
	[defaults synchronize];
	
	[self publishStream];
}

-(void)fbDidNotLogin:(BOOL)cancelled {
	[[[UIAlertView alloc] initWithTitle:@"Error" message:@"Sorry, an error occurred while logging in." delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil] show];
}

- (void)fbDidLogout {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:nil forKey:ACCESS_TOKEN_KEY];
	[defaults setObject:nil forKey:EXPIRATION_DATE_KEY];
	[defaults synchronize];
}

- (void)fbDidExtendToken:(NSString*)accessToken expiresAt:(NSDate*)expiresAt{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:accessToken forKey:ACCESS_TOKEN_KEY];
	[defaults setObject:expiresAt forKey:EXPIRATION_DATE_KEY];
	[defaults synchronize];
}

- (void)fbSessionInvalidated{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:nil forKey:ACCESS_TOKEN_KEY];
	[defaults setObject:nil forKey:EXPIRATION_DATE_KEY];
	[defaults synchronize];
}

-(IBAction)showSongList:(id)sender{
    [train stop];
    SongListViewController *songlist = [[SongListViewController alloc] initWithNibName:@"SongListViewController" bundle:nil];
    [self.navigationController pushViewController:songlist animated:YES];
}

-(IBAction)playAmbientSount:(id)sender{
    UIButton *button = (UIButton *)sender;
    if (button.tag == 1) {
        [soundHelper playAudio:@"train2.mp3"];
    }
    else if (button.tag == 2) {
        [soundHelper playAudio:@"bleat1.mp3"];
    }
    else if (button.tag == 3) {
        [soundHelper playAudio:@"bleat2.mp3"];
    }
}

-(IBAction)showAbout:(id)sender{
    [train stop];
    AboutViewController *about = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
    [self.navigationController pushViewController:about animated:YES];
}


-(IBAction)showShare:(id)sender{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	facebook.accessToken = [defaults objectForKey:ACCESS_TOKEN_KEY];
    facebook.expirationDate = [defaults objectForKey:EXPIRATION_DATE_KEY];
	
	if([facebook isSessionValid]){
		[self publishStream];
	}
	else {
		[facebook authorize:permissions];
	}
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    soundHelper = [[SoundHelper alloc] init];
	[soundHelper initializeAudioPlayer];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSString *sound = [NSString stringWithFormat:@"train.mp3"];
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], sound]];
    NSError *error;
    train = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    
    if (train == nil){
        NSLog(@"%@",[error localizedDescription]);
    }
    else{
        train.volume = 1;
        train.numberOfLoops = 0;
        [train play];
    }

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
