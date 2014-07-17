#import "UIView+FirstResponder.h"


#pragma mark Class Definition

@implementation UIView (FirstResponder)


#pragma mark - Public Methods

+ (UIView *)findFirstResponder
{
	UIView *mainView = [UIApplication sharedApplication].keyWindow;
	return [mainView findFirstResponder];
}

+ (void)resignFirstResponderWithCompletion: (void (^)(void))completion
{
	UIView *firstResponder = [UIView findFirstResponder];
	
	if (firstResponder != nil)
	{
		[firstResponder resignFirstResponder];
		
		// Call completion, after a delay.
		if (completion != nil)
		{
			// Copy the block;
			completion = [completion copy];
			
			// TODO: CLUDGE: Call the block after a delay.
			// Perhaps use a keyboard observer if the keyboard is up...
			[self performSelector: @selector(_performBlock:)
				withObject: completion
				afterDelay: 0.3];
		}
	}
	else
	{
		// Call completion, if provided.
		if (completion != nil)
		{
			completion();
		}
	}
}

- (UIView *)findFirstResponder
{
    if (self.isFirstResponder)
	{
        return self;     
    }

    for (UIView *subView in self.subviews)
	{
        UIView *firstResponder = [subView findFirstResponder];
		
        if (firstResponder != nil)
		{
            return firstResponder;
        }
    }

    return nil;
}


#pragma mark - Private Methods

+ (void)_performBlock: (void (^)(void))block
{
	block();
}

@end