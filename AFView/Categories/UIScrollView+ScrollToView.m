#import "UIScrollView+ScrollToView.h"
#import "UIView+FirstResponder.h"
#import "UIView+Layout.h"
#import <objc/runtime.h>


#pragma mark Constants

#define MARGIN 8.f


#pragma mark - Class Definition

@implementation UIScrollView (ScrollToView)


#pragma mark - Properties

// Use the addresses as the key.
static char CACHED_BOTTOM_CONTENT_INSET_KEY;

- (NSNumber *)cachedBottomContentInset
{
	return (NSNumber *)objc_getAssociatedObject(self, &CACHED_BOTTOM_CONTENT_INSET_KEY);
}

- (void)setCachedBottomContentInset: (NSNumber *)cachedBottomContentInset
{
	objc_setAssociatedObject(self, &CACHED_BOTTOM_CONTENT_INSET_KEY, cachedBottomContentInset, OBJC_ASSOCIATION_RETAIN);
}


#pragma mark - Public Methods

- (void)scrollToView: (UIView *)view
	duration: (NSTimeInterval)duration
	options: (UIViewAnimationOptions)options
	bottomInset: (CGFloat)bottomInset
{
	// Set the cached bottom content inset, to allow resetting it later.
	if ([self cachedBottomContentInset] == nil)
	{
		[self setCachedBottomContentInset: [NSNumber numberWithFloat: self.contentInset.bottom]];
	}

	UIEdgeInsets contentInset = self.contentInset;
	contentInset.bottom = bottomInset;

	CGPoint contentSpacePoint = [view.superview convertPoint: view.frame.origin
		toView: self];
		
	// Send the point on its mystical journey.
	contentSpacePoint.y -= MARGIN;
	
	CGPoint screenSpacePoint = CGPointMake(0.f, contentSpacePoint.y - self.contentOffset.y);
	
	CGFloat screenMaxY = self.height - bottomInset - view.height - MARGIN;
	CGFloat screenMinY = 0.f;
	
	if (screenSpacePoint.y < screenMinY)
	{
		[UIView animateWithDuration: duration
			delay: 0
			options: options
			animations: ^
			{
				self.contentOffset = CGPointMake(0.f, contentSpacePoint.y);
			}
			completion: ^(BOOL finished)
			{
				self.contentInset = contentInset;
			}];
	}
	else if (screenSpacePoint.y > screenMaxY)
	{
		// Determine the content offset that sits right below the keyboard.
		contentSpacePoint.y = contentSpacePoint.y - screenMaxY + MARGIN;

		[UIView animateWithDuration: duration
			delay: 0
			options: options
			animations: ^
			{
				self.contentOffset = CGPointMake(0.f, contentSpacePoint.y);
			}
			completion: ^(BOOL finished)
			{
				self.contentInset = contentInset;
			}];
	}

}

- (void)scrollToView: (UIView *)view
	keyboardInfo: (AFKeyboardInfo *)keyboardInfo
{
	[self scrollToView: view
		duration: keyboardInfo.animationDuration
		options: keyboardInfo.animationCurveAsOptions
		bottomInset: keyboardInfo.endFrame.size.height];
}

- (void)scrollToFirstResponderWithKeyboardInfo: (AFKeyboardInfo *)keyboardInfo
{
	UIView *view = [UIWindow findFirstResponder];
	
	[self scrollToView: view
		keyboardInfo: keyboardInfo];
}

- (void)clearBottomInsetWithDuration: (NSTimeInterval)duration
	options: (UIViewAnimationOptions)options
{
	UIEdgeInsets contentInset = self.contentInset;
	contentInset.bottom = 0.f;
	
	// Get the cached bottom content inset.
	NSNumber *cachedBottomContentInset = [self cachedBottomContentInset];
	
	// Apply the cached bottom content inset, if set.
	if (cachedBottomContentInset != nil)
	{
		contentInset.bottom = [cachedBottomContentInset floatValue];
		
		// Unset the cached copy.
		[self setCachedBottomContentInset: nil];
	}
	
	[UIView animateWithDuration: duration
		delay: 0
		options: options
		animations: ^
		{
			self.contentInset = contentInset;
		}
		completion: nil];
}

- (void)sizeToFitContent
{
	CGFloat height = 0;
	
	for (UIView *view in self.subviews)
	{
		// Only take into account visible views.
		if (view.hidden == NO)
		{
			CGFloat position = view.frame.size.height + view.frame.origin.y;
			
			if (position > height)
			{
				height = position;
			}
		}
	}
	
	CGSize contentSize = self.contentSize;
	contentSize.height = height;
	self.contentSize = contentSize;
}


@end