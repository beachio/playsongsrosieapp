//
//  UIDevice+Hardware.h
//  
//
//  Created by Bala Bhadra Maharjan on 6/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define IPHONE_1G_NAMESTRING @"iPhone 1G"
#define IPHONE_3G_NAMESTRING @"iPhone 3G"
#define IPHONE_3GS_NAMESTRING @"iPhone 3GS"
#define IPOD_1G_NAMESTRING @"iPod touch 1G"
#define IPOD_2G_NAMESTRING @"iPod touch 2G"
#define SIMULATOR_NAMESTRING @"i386"

@interface UIDevice (Hardware)
- (NSString *) platform;
- (NSString *) platformString;
+ (BOOL)isIPad;
@end
