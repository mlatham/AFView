

#pragma mark Class Interface

@interface UIView (Animation)


#pragma mark - Static Methods

// Animates using the provided blocks if "animate" is true,
// otherwise simply calls animations, then completion blocks.
+ (void)animateIf: (BOOL)animate
	animateWithDuration: (NSTimeInterval)duration 
	delay: (NSTimeInterval)delay 
	options: (UIViewAnimationOptions)options
	animations: (void (^)(void))animations 
	completion: (void (^)(BOOL finished))completion;


#pragma mark - Instance Methods

// Shakes this UIView.
- (void)shake;


@end