#import "UIView+Layout.h"


#pragma mark Class Definition

@implementation UIView (Layout)


#pragma mark - Properties

- (CGFloat)x
{
	CGFloat x = self.center.x - (self.width / 2.0f);

	return x;
}

- (void)setX: (CGFloat)x
{
	CGPoint viewCenter = self.center;

	// Floor the x origin to avoid subpixel rendering.
	viewCenter.x = floor(x) + (self.width / 2.0f);

	self.center = viewCenter;
}

- (CGFloat)y
{
	CGFloat y = self.center.y - (self.height / 2.0f);

	return y;
}

- (void)setY: (CGFloat)y
{
	CGPoint viewCenter = self.center;

	// Floor the y origin to avoid subpixel rendering.
	viewCenter.y = floorf(y) + (self.height / 2.0f);

	self.center = viewCenter;
}

- (CGFloat)width
{
	CGFloat width = self.bounds.size.width;

	return width;
}

- (void)setWidth: (CGFloat)width
{
	// Changing the width of a view through its bounds updates the view's x origin
	// so it needs to be set again after the the bounds have been changed.
	CGFloat previousX = self.x;

	CGRect viewBounds = self.bounds;

	// Floor the width to avoid subpixel rendering
	viewBounds.size.width = floorf(width);

	self.bounds = viewBounds;

	self.x = previousX;
}

- (CGFloat)height
{
	CGFloat height = self.bounds.size.height;

	return height;
}

- (void)setHeight: (CGFloat)height
{
	// Changing the height of a view through its bounds updates the view's y origin
	// so it needs to be set again after the the bounds have been changed.
	CGFloat previousY = self.y;

	CGRect viewBounds = self.bounds;

	// Floor the height to avoid subpixel rendering.
	viewBounds.size.height = floorf(height);

	self.bounds = viewBounds;

	self.y = previousY;
}


#pragma mark - Public Methods

- (void)alignHorizontally: (UIViewHorizontalAlignment)horizontalAlignment
{
	if (self.superview == nil)
	{
		return;
	}

	switch (horizontalAlignment)
	{
		case UIViewHorizontalAlignmentCenter:
		{
			self.x = (self.superview.width - self.width) / 2.0f;

			break;
		}

		case UIViewHorizontalAlignmentLeft:
		{
			self.x = 0.0f;

			break;
		}

		case UIViewHorizontalAlignmentRight:
		{
			self.x = self.superview.width - self.width;

			break;
		}
	}
}

- (void)alignVertically: (UIViewVerticalAlignment)verticalAlignment
{
	if (self.superview == nil)
	{
		return;
	}

	switch (verticalAlignment)
	{
		case UIViewVerticalAlignmentMiddle:
		{
			self.y = (self.superview.height - self.height) / 2.0f;

			break;
		}

		case UIViewVerticalAlignmentTop:
		{
			self.y = 0.0;

			break;
		}

		case UIViewVerticalAlignmentBottom:
		{
			self.y = self.superview.height - self.height;

			break;
		}
	}
}

- (void)alignHorizontally: (UIViewHorizontalAlignment)horizontalAlignment
	vertically: (UIViewVerticalAlignment)verticalAlignment
{
	[self alignHorizontally: horizontalAlignment];
	[self alignVertically: verticalAlignment];
}

- (void)removeAllSubviews
{
	[self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
}

- (id)firstAncestorViewWithClass: (Class)class
{
	UIView *view = self;
	
	while (view != nil)
	{
		if ([view isKindOfClass: class])
		{
			return view;
		}
		
		// Traverse up the ancestors.
		view = view.superview;
	}
	
	// No scroll view found.
	return nil;
}

- (UIScrollView *)firstAncestorScrollView
{
	UIView *view = self;
	
	while (view != nil)
	{
		// HACK: In iOS 7, every table view cell seems to contain a scrollview. Ignore it explicitly.
		if ([view isKindOfClass: [UIScrollView class]]
			&& [view isKindOfClass: NSClassFromString(@"UITableViewCellScrollView")] == NO)
		{
			return (UIScrollView *)view;
		}
		
		// Traverse up the ancestors.
		view = view.superview;
	}
	
	// No scroll view found.
	return nil;
}


@end // @implementation UIView (Layout)