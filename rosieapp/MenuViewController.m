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

@implementation MenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)showSongList:(id)sender{
    SongListViewController *songlist = [[SongListViewController alloc] initWithNibName:@"SongListViewController" bundle:nil];
    [self.navigationController pushViewController:songlist animated:YES];
}


-(IBAction)showAbout:(id)sender{

}


-(IBAction)showShare:(id)sender{

    
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
