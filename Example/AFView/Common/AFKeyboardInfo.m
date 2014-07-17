#import "AFKeyboardInfo.h"


#pragma mark Class Definition

@implementation AFKeyboardInfo


#pragma mark - Properties

- (UIViewAnimationOptions)animationCurveAsOptions
{
	return UNAnimationOptionsFromAnimationCurve(_animationCurve);
}


#pragma mark - Constructors

- (id)initWithEndFrame: (CGRect)endFrame
	animationDuration: (NSTimeInterval)animationDuration
	animationCurve: (UIViewAnimationCurve)animationCurve
	originalOptions: (NSDictionary *)originalOptions
{
	// Abort if base initializer fails.
	if ((self = [super init]) == nil)
	{
		return nil;
	}
	
	// Apply a minimum animation duration.
	if (animationDuration == 0)
	{
		animationDuration = 0.2f;
	}
	
	// Initialize instance variables.
	_endFrame = endFrame;
	_animationCurve = animationCurve;
	_originalOptions = originalOptions;
	_animationDuration = animationDuration;
	
	// Return initialized instance.
	return self;
}


#pragma mark - Methods

- (void)animate: (void (^)(void))animations
{
	// Animate using the keyboard options animation options.
	[UIView beginAnimations: nil
		context: NULL];
	[UIView setAnimationDuration: [_originalOptions[UIKeyboardAnimationDurationUserInfoKey] doubleValue]];
	[UIView setAnimationCurve: [_originalOptions[UIKeyboardAnimationCurveUserInfoKey] integerValue]];
	[UIView setAnimationBeginsFromCurrentState: YES];

	// Can be anything.
	if (animations != nil)
	{
		animations();
	}
	
	// Commit the animations.
	[UIView commitAnimations];
}

static inline UIViewAnimationOptions UNAnimationOptionsFromAnimationCurve(UIViewAnimationCurve animationCurve)
{	
	switch (animationCurve)
	{
		case UIViewAnimationCurveEaseInOut:
			return UIViewAnimationOptionCurveEaseInOut;
		case UIViewAnimationCurveEaseIn:
			return UIViewAnimationOptionCurveEaseIn;
		case UIViewAnimationCurveEaseOut:
			return UIViewAnimationOptionCurveEaseOut;
		case UIViewAnimationCurveLinear:
			return UIViewAnimationOptionCurveLinear;
	}
	
	return 0;
}


@end