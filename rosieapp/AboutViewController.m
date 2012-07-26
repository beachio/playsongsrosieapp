//
//  AboutViewController.m
//  rosieapp
//
//  Created by Bala Bhadra Maharjan on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AboutViewController.h"

@implementation AboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

-(IBAction)albumPressed:(id)sender{
    UIButton *button = (UIButton *)sender;
    if (button.tag == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://playsongsplus.com/cds/hush-a-bye/"]];
    }
    else if(button.tag == 2){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://playsongsplus.com/cds/five-little-field-mice/"]];
    }
    else if(button.tag == 3){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://playsongsplus.com/cds/rosie-the-little-red-car/"]];
    }
}

-(IBAction)back:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
