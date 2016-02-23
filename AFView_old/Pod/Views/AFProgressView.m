#import "AFProgressView.h"
#import "UIView+Layout.h"


#pragma mark Class Definition

@implementation AFProgressView
{
	@private __strong UIImageView *_backgroundImageView;
	@private __strong UIImageView *_fillImageView;
}


#pragma mark - Properties

- (void)setBackgroundImage: (UIImage *)backgroundImage
{
	_backgroundImage = backgroundImage;
	_backgroundImageView.image = backgroundImage;
}

- (void)setFillImage: (UIImage *)fillImage
{
	_fillImage = fillImage;
	_fillImageView.image = fillImage;
}

- (void)setProgress: (CGFloat)progress
{
	// Set progress.
	_progress = progress;

	// Update layout.
	[self setNeedsLayout];
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
	[self _initializeProgressView];
	
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
	[self _initializeProgressView];
	
	// Return initialized instance.
	return self;
}


#pragma mark - Overridden Methods

- (void)layoutSubviews
{
	// Set the frame.
	CGRect frame = _fillImageView.frame;
	frame.size.width = _backgroundImageView.width * _progress;
	if (_progress > 0.f
		&& frame.size.width < 10.f)
	{
		frame.size.width = 10.f;
	}
	else if (_progress == 0.f)
	{
		frame.size.width = 0.f;
	}
	_fillImageView.frame = frame;

	// Call base implementation.
	[super layoutSubviews];
}


#pragma mark - Private Methods

- (void)_initializeProgressView
{
	// Initialize background image view.
	_backgroundImageView = [[UIImageView alloc]
		initWithFrame: CGRectMake(
			0.f,
			0.f,
			self.frame.size.width,
			self.frame.size.height)];
	_backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	[self addSubview: _backgroundImageView];
	
	// Initialize fill image view.
	_fillImageView = [[UIImageView alloc]
		initWithFrame: CGRectMake(
			0.f,
			0.f,
			0.f,
			self.frame.size.height)];
	[self addSubview: _fillImageView];
}


@end