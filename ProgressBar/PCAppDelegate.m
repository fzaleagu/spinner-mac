//
//  PCAppDelegate.m
//  ProgressBar
//
//  Created by Patrick Chamelo on 8/26/12.
//  Copyright (c) 2012 Patrick Chamelo. All rights reserved.
//

#import "PCAppDelegate.h"
#import "PCProgressCirlceView.h"

@implementation PCAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application

    PCProgressCirlceView *progressView = [[PCProgressCirlceView alloc] initWithFrame:[self.window.contentView frame]];
    [self.window.contentView addSubview:progressView];
}

@end
