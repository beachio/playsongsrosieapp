//
//  TitleViewController.m
//  rosieapp
//
//  Created by Bala Bhadra Maharjan on 6/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TitleViewController.h"
#import "UIDevice+Hardware.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"

@implementation TitleViewController


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *imageName;
    if ([UIDevice isIPad]) {
		imageName = @"Default-Portrait.png";
    } else {
		imageName = @"Default.png";
    }
    brand = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    
    if ([UIDevice isIPad]) {
		brand.frame = CGRectMake(0, [[UIApplication sharedApplication] statusBarFrame].size.height, brand.frame.size.width, brand.frame.size.height);
    } else {
		brand.frame = CGRectMake(0, 0, brand.frame.size.width, brand.frame.size.height);
    }
    
	[self.view addSubview:brand];
    [NSTimer scheduledTimerWithTimeInterval:0.0 target:self selector:@selector(showLogo) userInfo:nil repeats:NO];
}

- (void)showLogo{
    NSInteger x,y;
    UIImageView *imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ruplay.png"]];
	if ([UIDevice isIPad]) {
		x = (self.view.bounds.size.width - imageview.frame.size.width)/2;
        y = 220;
    } else {
		x = (self.view.bounds.size.width - imageview.frame.size.width)/2;
        y = 100;
    }
    imageview.alpha = 0;
    imageview.frame = CGRectMake(x, y, imageview.frame.size.width, imageview.frame.size.height);
    [brand addSubview:imageview];
    
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1];
	[UIView setAnimationDelay:0.0];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(showDesc)];
	
    imageview.alpha = 1;
    
	[UIView commitAnimations];
}

- (void)showDesc{
    NSInteger x,y;
    UIImageView *imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ruplay_desc.png"]];
	if ([UIDevice isIPad]) {
		x = (self.view.bounds.size.width - imageview.frame.size.width)/2;
        y = 550;
    } else {
		x = (self.view.bounds.size.width - imageview.frame.size.width)/2;
        y = 280;
    }
    imageview.alpha = 0;
    imageview.frame = CGRectMake(x, y, imageview.frame.size.width, imageview.frame.size.height);
    [brand addSubview:imageview];
    
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1];
	[UIView setAnimationDelay:0.0];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(showLink)];
	
    imageview.alpha = 1;
    
	[UIView commitAnimations];
}

- (void)showLink{
    NSInteger x,y;
    UIImageView *imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ruplay_link.png"]];
	if ([UIDevice isIPad]) {
		x = (self.view.bounds.size.width - imageview.frame.size.width)/2;
        y = 1024;
    } else {
		x = (self.view.bounds.size.width - imageview.frame.size.width)/2;
        y = 480;
    }
    imageview.frame = CGRectMake(x, y, imageview.frame.size.width, imageview.frame.size.height);
    [brand addSubview:imageview];
    
    if ([UIDevice isIPad]) {
		x = (self.view.bounds.size.width - imageview.frame.size.width)/2;
        y = 920;
    } else {
		x = (self.view.bounds.size.width - imageview.frame.size.width)/2;
        y = 440;
    }
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.8];
	[UIView setAnimationDelay:0.0];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(startAnim)];
	
    imageview.frame = CGRectMake(x, y, imageview.frame.size.width, imageview.frame.size.height);;
    
	[UIView commitAnimations];
}

- (void)startAnim{
    sleep(2);
    [[[self.view subviews] lastObject] removeFromSuperview];
    littleCarFrame = littleCar.frame;
    nickieJillFrame = nickieJill.frame;
    
    NSInteger x,y;
	if ([UIDevice isIPad]) {
		x = 770;
        y = 1024;
    } else {
		x = 320;
        y = 480;
    }
    
    littleCar.frame = CGRectMake(x, littleCarFrame.origin.y, littleCarFrame.size.width, littleCarFrame.size.height);
    nickieJill.frame = CGRectMake(nickieJillFrame.origin.x, y, nickieJillFrame.size.width, nickieJillFrame.size.height);
    playSong.alpha = 0;
    lollipop.alpha = 0;
    
	[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(showLittleCarAnimation) userInfo:nil repeats:NO];
}

-(void)showLittleCarAnimation{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.8];
	[UIView setAnimationDelay:0.0];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(finishedLittleCarAnimation:finished:context:)];
	
    littleCar.frame = littleCarFrame;
		
	[UIView commitAnimations];
	
}

-(void)finishedLittleCarAnimation:(NSString*)animationID finished:(BOOL)finished context:(void*)context{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.8];
	[UIView setAnimationDelay:0.2];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(finishedNickieJillAnimation:finished:context:)];
	
	nickieJill.frame = nickieJillFrame;
	
	[UIView commitAnimations];
}

-(void)finishedNickieJillAnimation:(NSString*)animationID finished:(BOOL)finished context:(void*)context{
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.8];
	[UIView setAnimationDelay:0.2];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(finishedFadeAnimation:finished:context:)];
	
	lollipop.alpha = 1;
    playSong.alpha = 1;
	
	[UIView commitAnimations];
}

-(void)finishedFadeAnimation:(NSString*)animationID finished:(BOOL)finished context:(void*)context{
	[self performSelector:@selector(showMenu) withObject:nil afterDelay:0.8];
}

-(void)showMenu{
	UIWindow *window = [(AppDelegate *)[[UIApplication sharedApplication] delegate] window];
	CATransition *transition = [CATransition animation];
	
	transition.duration = 1;
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	transition.type = kCATransitionFade;
	[window.layer addAnimation:transition forKey:@"FADE_ANIM"];
	
	[[window subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
	AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    menuController = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    delegate.nav = [[UINavigationController alloc] initWithRootViewController:menuController];
    [window addSubview:delegate.nav.view];
    [delegate.nav setNavigationBarHidden:YES];
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


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

@end
