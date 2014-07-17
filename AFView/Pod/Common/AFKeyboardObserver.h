#import "AFKeyboardInfo.h"


#pragma mark Class Interface

@interface AFKeyboardObserver : NSObject


#pragma mark - Constructors

- (id)initWithTarget: (id)target
	willShowSelector: (SEL)willShowSelector
	willHideSelector: (SEL)willHideSelector;


#pragma mark - Properties

// Doesn't pick up keyboard state unless it has changed while observing.
@property (nonatomic, assign, readonly) BOOL isKeyboardVisible;


#pragma mark - Public Methods

- (void)startObserving;
- (void)stopObserving;


@end