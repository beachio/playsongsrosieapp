//
//  UIDevice+Hardware.m
//  
//
//  Created by Bala Bhadra Maharjan on 6/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//


#import "UIDevice+Hardware.h"
#include <sys/types.h>
#include <sys/sysctl.h>

@implementation UIDevice (Hardware)

/*
 Platforms
 iPhone1,1 = iPhone 1G
 iPhone1,2 = iPhone 3G
 iPhone2,1 = iPhone 3GS
 iPod1,1   = iPod touch 1G
 iPod2,1   = iPod touch 2G
 */

- (NSString *) platform{
	size_t size;
	sysctlbyname("hw.machine", NULL, &size, NULL, 0);
	char *machine = malloc(size);
	sysctlbyname("hw.machine", machine, &size, NULL, 0);
	NSString *platform = [NSString stringWithCString:machine];
	free(machine);
	return platform;
}

- (NSString *) platformString{
	NSString *platform = [self platform];
	if ([platform isEqualToString:@"iPhone1,1"]) return IPHONE_1G_NAMESTRING;
	if ([platform isEqualToString:@"iPhone1,2"]) return IPHONE_3G_NAMESTRING;
	if ([platform isEqualToString:@"iPhone2,1"]) return IPHONE_3GS_NAMESTRING;
	if ([platform isEqualToString:@"iPod1,1"])   return IPOD_1G_NAMESTRING;
	if ([platform isEqualToString:@"iPod2,1"])   return IPOD_2G_NAMESTRING;
	return platform;
}

+ (BOOL)isIPad{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 30200
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        return YES; 
    else
		return NO;
#else
        return NO;
#endif

}

@end
