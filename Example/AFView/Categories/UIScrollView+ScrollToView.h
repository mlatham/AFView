#import "AFKeyboardInfo.h"


#pragma mark Class Interface

@interface UIScrollView (ScrollToView)


#pragma mark - Instance Methods

- (void)scrollToView: (UIView *)view
	duration: (NSTimeInterval)duration
	options: (UIViewAnimationOptions)options
	bottomInset: (CGFloat)bottomInset;

- (void)scrollToView: (UIView *)view
	keyboardInfo: (AFKeyboardInfo *)keyboardInfo;

- (void)scrollToFirstResponderWithKeyboardInfo: (AFKeyboardInfo *)keyboardInfo;

- (void)clearBottomInsetWithDuration: (NSTimeInterval)duration
	options: (UIViewAnimationOptions)options;

- (void)sizeToFitContent;


@end