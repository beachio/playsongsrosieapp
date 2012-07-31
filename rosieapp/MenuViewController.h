//
//  MenuViewController.h
//  rosieapp
//
//  Created by Bala Bhadra Maharjan on 6/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SoundHelper.h"
#import "AboutViewController.h"
#import "FBConnect.h"

#define ACCESS_TOKEN_KEY @"fb_access_token"
#define EXPIRATION_DATE_KEY @"fb_expiration_date"

@interface MenuViewController : UIViewController<AVAudioPlayerDelegate, FBRequestDelegate, FBDialogDelegate, FBSessionDelegate>{
    SoundHelper *soundHelper;
    Facebook* facebook;
	NSArray* permissions;
    AVAudioPlayer *train;
}

@property (nonatomic, strong) Facebook* facebook;
-(IBAction)showSongList:(id)sender;
-(IBAction)showAbout:(id)sender;
-(IBAction)showShare:(id)sender;
-(IBAction)playAmbientSount:(id)sender;

- (void)publishStream;

@end
