#import "AFKeyboardObserver.h"


#pragma mark Class Definition

@implementation AFKeyboardObserver
{
	@private BOOL _isObservingKeyboardNotifications;
	@private SEL _willShowSelector;
	@private SEL _willHideSelector;
	@private __weak id _target;
	
	@private CGFloat _originalScrollViewBottomInset;
	@private __weak UIScrollView *_scrollView;
}


#pragma mark - Properties

- (void)setIsKeyboardVisible: (BOOL)isKeyboardVisible
{
	_isKeyboardVisible = isKeyboardVisible;
}


#pragma mark - Constructors

- (id)initWithTarget: (id)target
	willShowSelector: (SEL)willShowSelector
	willHideSelector: (SEL)willHideSelector
{
	// Abort if base initializer fails.
	if ((self = [super init]) == nil)
	{
		return nil;
	}
	
	// Initialize instance variables.
	_target = target;
	_willShowSelector = willShowSelector;
	_willHideSelector = willHideSelector;
	_isObservingKeyboardNotifications = NO;
	
	// Return initialized instance.
	return self;
}

- (id)initWithScrollView: (UIScrollView *)scrollView
{
	if ((self = [self initWithTarget: self
		willShowSelector: @selector(_showScrollViewInsets:)
		willHideSelector: @selector(_hideScrollViewInsets:)]) == nil)
	{
		return nil;
	}
	
	_scrollView = scrollView;
	
	return self;
}


#pragma mark - Destructor

- (void)dealloc
{
	// Stop observing.
	if (_isObservingKeyboardNotifications == YES)
	{
		// Unregister for keyboard notifications.
		[[NSNotificationCenter defaultCenter]
			removeObserver: self
			name: UIKeyboardWillShowNotification
			object: nil];
		[[NSNotificationCenter defaultCenter]
			removeObserver: self
			name: UIKeyboardWillHideNotification
			object: nil];
		
		// Track whether or not we're observing notifications.
		_isObservingKeyboardNotifications = NO;
	}
}


#pragma mark - Public Methods

- (void)startObserving
{
	if (_isObservingKeyboardNotifications == YES)
	{
		return;
	}

	// Register for keyboard notifications.
	[[NSNotificationCenter defaultCenter]
		addObserver: self
		selector: @selector(_keyboardWillShow:)
		name: UIKeyboardWillShowNotification
		object: nil];
	[[NSNotificationCenter defaultCenter]
		addObserver: self
		selector: @selector(_keyboardWillHide:)
		name: UIKeyboardWillHideNotification
		object: nil];
		
	// Track whether or not we're observing notifications.
	_isObservingKeyboardNotifications = YES;
}

- (void)stopObserving
{
	if (_isObservingKeyboardNotifications == NO)
	{
		return;
	}
	
	// Unregister for keyboard notifications.
	[[NSNotificationCenter defaultCenter]
		removeObserver: self
		name: UIKeyboardWillShowNotification
		object: nil];
	[[NSNotificationCenter defaultCenter]
		removeObserver: self
		name: UIKeyboardWillHideNotification
		object: nil];
	
	// Track whether or not we're observing notifications.
	_isObservingKeyboardNotifications = NO;
}


#pragma mark - Private Methods

- (void)_showScrollViewInsets: (AFKeyboardInfo *)keyboardInfo
{
	if (_scrollView == nil || _isKeyboardVisible) { return; }

	UIEdgeInsets contentInset = _scrollView.contentInset;
	_originalScrollViewBottomInset = contentInset.bottom;
	contentInset.bottom = keyboardInfo.endFrame.size.height;
	_scrollView.contentInset = contentInset;
}

- (void)_hideScrollViewInsets: (AFKeyboardInfo *)keyboardInfo
{
	if (_scrollView == nil || _isKeyboardVisible == NO) { return; }
	
	UIEdgeInsets contentInset = _scrollView.contentInset;
	contentInset.bottom = _originalScrollViewBottomInset;
	_scrollView.contentInset = contentInset;
}

- (void)_keyboardWillShow: (NSNotification *)notification
{
	// Fire another keyboard will show notification, even if the keyboard is already visible.

	NSDictionary *userInfo = [notification userInfo];
	
	// Get the keyboard end frame.
	NSTimeInterval animationDuration;
	UIViewAnimationCurve animationCurve;
	CGRect endFrame;

	[[userInfo objectForKey: UIKeyboardAnimationCurveUserInfoKey]
		getValue: &animationCurve];
	[[userInfo objectForKey: UIKeyboardAnimationDurationUserInfoKey]
		getValue: &animationDuration];
	[[userInfo objectForKey: UIKeyboardFrameEndUserInfoKey]
		getValue: &endFrame];
		
	// Create a keyboard info object to wrap the info.
	AFKeyboardInfo *keyboardInfo = [[AFKeyboardInfo alloc]
		initWithEndFrame: endFrame
		animationDuration: animationDuration
		animationCurve: animationCurve
		originalOptions: userInfo];
	
	// Call the callback selector.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
	[_target performSelector: _willShowSelector
		withObject: keyboardInfo];
#pragma clang diagnostic pop

	// Toggle the keyboard visibility.
	self.isKeyboardVisible = YES;
}

- (void)_keyboardWillHide: (NSNotification *)notification
{
	// If the keyboard is not visible, skip this notification.
	if (_isKeyboardVisible == NO)
	{
		return;
	}

	NSDictionary *userInfo = [notification userInfo];
	
	// Get the keyboard animation properties.
	NSTimeInterval animationDuration;
	UIViewAnimationCurve animationCurve;
	CGRect endFrame;

	[[userInfo objectForKey: UIKeyboardAnimationCurveUserInfoKey]
		getValue: &animationCurve];
	[[userInfo objectForKey: UIKeyboardAnimationDurationUserInfoKey]
		getValue: &animationDuration];
	[[userInfo objectForKey: UIKeyboardFrameEndUserInfoKey]
		getValue: &endFrame];
		
	// Create a keyboard info object to wrap the info.
	AFKeyboardInfo *keyboardInfo = [[AFKeyboardInfo alloc]
		initWithEndFrame: endFrame
		animationDuration: animationDuration
		animationCurve: animationCurve
		originalOptions: userInfo];

	// Call the callback selector.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
	[_target performSelector: _willHideSelector
		withObject: keyboardInfo];
#pragma clang diagnostic pop

	// Toggle the keyboard visibility.
	self.isKeyboardVisible = NO;
}


@end
