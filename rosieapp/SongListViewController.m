//
//  SongListViewController.m
//  rosieapp
//
//  Created by Bala Bhadra Maharjan on 6/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SongListViewController.h"
#import "UIDevice+Hardware.h"

@implementation SongListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        songList = [[NSMutableArray alloc] initWithObjects:@"Here We Are Together ",
                    @"Peek-a-Boo",
                    @"Dance, Thumbkin, Dance",
                    @"Rosie, The Little Red Car",
                    @"The Clock Says Tick Tock",
                    @"Dabbling Ducks",
                    @"Mr Sun",
                    @"Hop Up My Ladies",
                    @"Lippity Lop",
                    @"Dance All The Night",
                    @"We Can Hear You",
                    @"Chug-a-Chug Chug",
                    @"Cherry Tree Farm",
                    @"Puffa Train",
                    @"In The Band",
                    @"As I Was Walking / Everybody Says Sit Down",
                    @"Shake Song",
                    @"One Little Dreamboat",
                    nil];
        
        welcomeMessages = [[NSMutableArray alloc] initWithObjects:@"Hello my friends!",
                           @"Are you here to play with me?",
                           @"You can pick a song from the clouds...",
                           @"Or tickle my ears and I'll pick you a song!",
                           nil];
        
        songChoiceMessages = [[NSMutableArray alloc] initWithObjects:@"Blistering Barnacles! Great choice. Here we go...",
                              nil];
        
        currentMsg = 0;
    }
    return self;
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
    cloudFrame1 = [NSMutableArray array];
    cloudFrame2 = [NSMutableArray array];
    if([UIDevice isIPad]){
        [cloudFrame1 addObject:[NSValue valueWithCGRect:CGRectMake(376, 20, 384, 286)]];
        [cloudFrame1 addObject:[NSValue valueWithCGRect:CGRectMake(20, 192, 395, 227)]];
        [cloudFrame1 addObject:[NSValue valueWithCGRect:CGRectMake(344, 361, 402, 249)]];
        
        [cloudFrame2 addObject:[NSValue valueWithCGRect:CGRectMake(20, 8, 384, 286)]];
        [cloudFrame2 addObject:[NSValue valueWithCGRect:CGRectMake(349, 178, 395, 227)]];
        [cloudFrame2 addObject:[NSValue valueWithCGRect:CGRectMake(11, 342, 402, 249)]];
    }
    else{
        [cloudFrame1 addObject:[NSValue valueWithCGRect:CGRectMake(148, 12, 172, 110)]];
        [cloudFrame1 addObject:[NSValue valueWithCGRect:CGRectMake(10, 89, 174, 100)]];
        [cloudFrame1 addObject:[NSValue valueWithCGRect:CGRectMake(139, 156, 176, 110)]];
        
        [cloudFrame2 addObject:[NSValue valueWithCGRect:CGRectMake(11, 14, 172, 110)]];
        [cloudFrame2 addObject:[NSValue valueWithCGRect:CGRectMake(140, 84, 174, 100)]];
        [cloudFrame2 addObject:[NSValue valueWithCGRect:CGRectMake(7, 153, 176, 110)]];
    }
    
    //TODO: Configure scrollview
    NSInteger pages = ceil([songList count]/3.0f);
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * pages, scrollView.frame.size.height);
    
	clouds = [[NSMutableArray alloc] init];
	for (unsigned i = 0; i < [songList count]; i++) {
		[clouds addObject:[NSNull null]];
	}
	
	[self loadScrollViewWithPage:0];
	[self loadScrollViewWithPage:1];
    
    msgTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(switchMsg) userInfo:nil repeats:YES];    
    [msgTimer fire];
}

-(void)loadScrollViewWithPage:(NSInteger)page{
    NSInteger pages = ceil([songList count]/3.0f);
    if (page < 0) 
		return;
    if (page >= pages) 
		return;
	
    for (NSInteger i = 0; i < 3; i++) {
        OBShapedButton *cloud = [clouds objectAtIndex:page*3+i];
        if ((NSNull *)cloud == [NSNull null]) {
            cloud = [OBShapedButton buttonWithType:UIButtonTypeCustom];
            [cloud setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"cloud%d.png",i+1]] forState:UIControlStateNormal];
            [clouds replaceObjectAtIndex:page*3+i withObject:cloud];
            if([UIDevice isIPad]){
                [cloud.titleLabel setFont:[UIFont boldSystemFontOfSize:28]];
            }
            else{
                [cloud.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
            }
            [cloud.titleLabel setLineBreakMode:UILineBreakModeWordWrap];
            [cloud.titleLabel setTextAlignment:UITextAlignmentCenter];

            [cloud.titleLabel setNumberOfLines:3];
            [cloud setTitle:[songList objectAtIndex:page*3+i] forState:UIControlStateNormal];
            [cloud setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [cloud setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
            cloud.tag = page*3+i;
            [cloud addTarget:self action:@selector(cloudPressed:) forControlEvents:UIControlEventTouchUpInside];
            
            NSMutableArray *cloudFrame;
            
            if(page%2 == 0){
                cloudFrame = cloudFrame1;
            }
            else{
                cloudFrame = cloudFrame2;
            }
            
            CGRect rect = [((NSValue *)[cloudFrame objectAtIndex:i]) CGRectValue];
            rect = CGRectMake(rect.origin.x + self.view.bounds.size.width * page, rect.origin.y, rect.size.width, rect.size.height);
            cloud.frame = rect;
        }
        if (cloud.superview == nil) {
            [scrollView addSubview:cloud];
        }
        
    }
}

#pragma mark -
#pragma mark scrollView delegate methods
- (void)scrollViewDidScroll:(UIScrollView *)sender {
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
}

-(void)cloudPressed:(id)sender{
    if ([msgTimer isValid]) {
        NSLog(@"Timer invalidated");
        [msgTimer invalidate];
    }
    trackNumber = [(UIButton *)sender tag];
    NSString * msg = [songChoiceMessages objectAtIndex:arc4random()%[songChoiceMessages count]];
    [self setRabbitMsgText:msg];
    [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(playSong) userInfo:nil repeats:NO];
}

     
-(void)switchMsg{
    if (currentMsg < [welcomeMessages count]) {
        [self setRabbitMsgText:[welcomeMessages objectAtIndex:currentMsg]];
         currentMsg++;
    }
    else{
        NSLog(@"Timer invalidated");
        [msgTimer invalidate];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.8];
        [UIView setAnimationDelay:0.0];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(finishedFadeAnimation:finished:context:)];
        
        bubble.hidden = YES;
        rabbitMsg.hidden = YES;
        
        [UIView commitAnimations];
    }
         
}

-(IBAction)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)randomSong{
    if ([msgTimer isValid]) {
        NSLog(@"Timer invalidated");
        [msgTimer invalidate];
    }
    trackNumber = arc4random()%[songList count] + 1;
    [self setRabbitMsgText:@"Here we go..."];
    [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(playSong) userInfo:nil repeats:NO];
}

-(void)setRabbitMsgText:(NSString *)msg{
    
    rabbitMsg.hidden = NO;
    bubble.hidden = NO;
    
    rabbitMsg.text = msg;
}
     
-(void)playSong{
    bubble.hidden = YES;
    rabbitMsg.hidden = YES;
    NSLog(@"%d", trackNumber);
    NSLog(@"play the song");
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
