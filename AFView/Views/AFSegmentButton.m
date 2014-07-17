#import "AFSegmentButton.h"
#import "UIView+Layout.h"


#pragma mark - Class Definition

@implementation AFSegmentButton


#pragma mark - Properties

- (void)setBackgroundHidden: (BOOL)backgroundHidden
{
	_backgroundHidden = backgroundHidden;
	
	_keyline.y = backgroundHidden
		? 0.f
		: 3.f;
	_keyline.height = backgroundHidden
		? self.frame.size.height
		: self.frame.size.height - 3.f * 2.f;
}


#pragma mark - Constructors

- (id)initWithFrame: (CGRect)frame
{
	// Abort if base initializer fails.
	if ((self = [super initWithFrame: frame]) == nil)
	{
		return nil;
	}
	
	// Initialize view.
	[self _initializeSegmentButton];
	
	// Return initialized instance.
	return self;
}

- (id)initWithCoder: (NSCoder *)coder
{
	// Abort if base initializer fails.
	if ((self = [super initWithCoder: coder]) == nil)
	{
		return nil;
	}
	
	// Initialize view.
	[self _initializeSegmentButton];
	
	// Return initialized instance.
	return self;
}


#pragma mark - Private Methods

- (void)_initializeSegmentButton
{
	// Allow titles to wrap.
	self.titleLabel.numberOfLines = 0;
	self.titleLabel.textAlignment = NSTextAlignmentCenter;
	
	// Add the right keyline.
	_keyline = [[UIImageView alloc]
		initWithFrame: CGRectMake(
			0.f,
			0.f,
			1.f,
			self.frame.size.height)];
	_keyline.autoresizingMask = UIViewAutoresizingFlexibleHeight
		| UIViewAutoresizingFlexibleRightMargin;
	[self addSubview: _keyline];
}


@end