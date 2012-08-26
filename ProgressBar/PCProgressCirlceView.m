//
//  PCProgressCirlceView.m
//  ProgressBar
//
//  Created by Patrick Chamelo on 8/26/12.
//  Copyright (c) 2012 Patrick Chamelo. All rights reserved.
//


@implementation NSView (Extensions)


// ------------------------------------------------------------------------------------------
#pragma mark - Extending NSView
// ------------------------------------------------------------------------------------------
- (void)setCenter:(NSPoint)center
{
    [self setFrameOrigin:NSMakePoint(floorf(center.x - (NSWidth([self bounds])) / 2),
                                     floorf(center.y - (NSHeight([self bounds])) / 2))];
}

- (NSPoint)getCenter
{
    return NSMakePoint(floorf(self.bounds.origin.x + (self.bounds.size.width / 2)),
                       floorf(self.bounds.origin.y + (self.bounds.size.height / 2)));
}


- (NSPoint)getCenterOnFrame
{
    return NSMakePoint(floorf(self.frame.origin.x + (self.frame.size.width / 2)),
                       floorf(self.frame.origin.y + (self.frame.size.height / 2)));
}

@end



#import "PCProgressCirlceView.h"

#import <QuartzCore/QuartzCore.h>


// ------------------------------------------------------------------------------------------


CGFloat DegreesToRadians(CGFloat degrees)
{
    return degrees * M_PI / 180;
}


NSNumber* DegreesToNumber(CGFloat degrees)
{
    return [NSNumber numberWithFloat:
            DegreesToRadians(degrees)];
}


NSPoint getCenter(NSView *view)
{
    return NSMakePoint(floorf(view.bounds.origin.x + (view.bounds.size.width / 2)),
                       floorf(view.bounds.origin.y + (view.bounds.size.height / 2)));
}


// ------------------------------------------------------------------------------------------


@interface PCProgressCirlceView()

- (CAAnimation*)rotateAnimation;

@end


@implementation PCProgressCirlceView


@synthesize progressImage = _progressImage;
@synthesize badgeView = _badgeView;


// -----------------------
#pragma mark - Initializer
// -----------------------
- (id)initWithFrame:(NSRect)frame
{
    if ((self = [super initWithFrame:frame]))
    {
        
        // badge
        NSImage *badge = [NSImage imageNamed:@"Badge"];
        
        // create the NSImage view
        self.badgeView = [[NSImageView alloc] initWithFrame:NSMakeRect(0, 0,
                                                                       badge.size.width,
                                                                       badge.size.height)];
        
        // set it on the center of the parent container
        [self.badgeView setCenter:[self getCenter]];
        
        // set the badge iamge
        [self.badgeView setImage:badge];
        
        
        // spinner image
        NSImage *spinner = [NSImage imageNamed:@"Bar"];
        
        // create the progress image view
        self.progressImage = [[NSImageView alloc] initWithFrame:NSMakeRect(0, 0,
                                                                        spinner.size.width,
                                                                        spinner.size.height)];
        
        // enable its layer for the core animation
        self.progressImage.wantsLayer = YES;
                
        // set the center of the progress image
        // to the center of the badge
        [self.progressImage setCenter:[self.badgeView getCenterOnFrame]];
        
        // set the spinner image in the NSImage View
        [self.progressImage setImage:spinner];

        // first add the progress image in the container
        [self addSubview:self.progressImage];
        
        // then add the badge view
        [self addSubview:self.badgeView];

        // spin
        [self spin];
    }
    
    return self;
}


// -----------------------
#pragma mark - Spinning
// -----------------------
- (void)spin
{
    // ensure the acnhor point is the center
    // so it animates with respect to the center
    self.progressImage.layer.anchorPoint = CGPointMake(0.5, 0.5);
    
    // add the animation to the layer
    [self.progressImage.layer addAnimation:[self rotateAnimation] forKey:@"rotate"];
}


- (void)stop
{
    // remove the animations from the layer
    [self.progressImage.layer removeAllAnimations];
}


// -----------------------
#pragma mark - Rotate Animation
// -----------------------
- (CAAnimation*)rotateAnimation;
{
    // create a CABasic animation
    CABasicAnimation *animation = [CABasicAnimation
                                   animationWithKeyPath:@"transform.rotation.z"];
    
    // set the values for the rotation
    animation.fromValue = DegreesToNumber(359);
    animation.toValue = DegreesToNumber(0);
    animation.removedOnCompletion = NO;
    
    // set the speed and the fill mode
    animation.speed = 0.5f;
    animation.fillMode = kCAFillModeBackwards;
    
    // set the repeat count
    animation.repeatCount = HUGE_VALF;
    
    return animation;
}


@end
