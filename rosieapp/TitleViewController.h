//
//  TitleViewController.h
//  rosieapp
//
//  Created by Bala Bhadra Maharjan on 6/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuViewController.h"

@interface TitleViewController : UIViewController{
    MenuViewController *menuController;
    IBOutlet UIImageView *littleCar;
    IBOutlet UIImageView *lollipop;
    IBOutlet UIImageView *playSong;
    IBOutlet UIImageView *nickieJill;
    
    CGRect littleCarFrame;
    CGRect nickieJillFrame;
}

@end
