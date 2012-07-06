//
//  SongListViewController.h
//  rosieapp
//
//  Created by Bala Bhadra Maharjan on 6/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OBShapedButton.h"

@interface SongListViewController : UIViewController{
    NSMutableArray *songList;
    NSMutableArray *welcomeMessages;
    NSMutableArray *songChoiceMessages;
    
    NSMutableArray *cloudFrame1;
    NSMutableArray *cloudFrame2;
    
    NSInteger trackNumber;
    
    NSTimer *msgTimer;
    NSInteger currentMsg;
    
    NSMutableArray *clouds;
    
    IBOutlet UIImageView *bubble;
    
    IBOutlet UILabel *rabbitMsg;
    
    IBOutlet UIScrollView *scrollView;
    
    IBOutlet UIButton *rabbit;

}

-(IBAction)back;
-(IBAction)randomSong:(id)sender;
-(void)playSong;
-(void)setRabbitMsgText:(NSString *)msg;
-(void)loadScrollViewWithPage:(NSInteger)page;

@end
