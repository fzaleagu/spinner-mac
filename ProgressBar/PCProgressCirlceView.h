//
//  PCProgressCirlceView.h
//  ProgressBar
//
//  Created by Patrick Chamelo on 8/26/12.
//  Copyright (c) 2012 Patrick Chamelo. All rights reserved.
//


@interface PCProgressCirlceView : NSView

@property (nonatomic, strong) NSImageView *progressImage;
@property (nonatomic, strong) NSImageView *badgeView;

- (void)spin;
- (void)stop;

@end
