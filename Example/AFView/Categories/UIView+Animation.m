#import "UIView+Animation.h"


#pragma mark Class Definition

@implementation UIView (Animation)


#pragma mark - Public Methods

+ (void)animateIf: (BOOL)animate
	animateWithDuration: (NSTimeInterval)duration 
	delay: (NSTimeInterval)delay 
	options: (UIViewAnimationOptions)options
	animations: (void (^)(void))animations 
	completion: (void (^)(BOOL finished))completion
{
	if (animate == YES)
	{
		// animate change
		[UIView animateWithDuration: duration 
			delay: delay 
			options: options 
			animations: animations 
			completion: completion];
	}
	else
	{
		// explicitly apply change, if provided.
		if (animations != nil)
		{
			animations();
		}
		
		// call completion, if provided.
		if (completion != nil)
		{
			completion(YES);
		}
	}
}

- (void)shake
{
	CGFloat t = 2.0;
	
    CGAffineTransform translateRight  = CGAffineTransformTranslate(CGAffineTransformIdentity, t, 0.0);
    CGAffineTransform translateLeft = CGAffineTransformTranslate(CGAffineTransformIdentity, -t, 0.0);

    self.transform = translateLeft;

    [UIView animateWithDuration: 0.07
		delay: 0.0
		options: UIViewAnimationOptionAutoreverse|UIViewAnimationOptionRepeat
		animations: ^
		{
			[UIView setAnimationRepeatCount: 2.0];
			
			self.transform = translateRight;
		}
		completion: ^(BOOL finished)
		{
			if (finished)
			{
				[UIView animateWithDuration: 0.05
					delay: 0.0
					options: UIViewAnimationOptionBeginFromCurrentState
					animations: ^
					{
						self.transform = CGAffineTransformIdentity;
					}
					completion: nil];
			}
		}];
}


@end