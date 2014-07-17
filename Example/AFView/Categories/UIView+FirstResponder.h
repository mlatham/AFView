

#pragma mark Class Interface

@interface UIView (FirstResponder)


#pragma mark - Static Methods

+ (UIView *)findFirstResponder;

+ (void)resignFirstResponderWithCompletion: (void (^)(void))completion;


#pragma mark - Instance Methods

- (UIView *)findFirstResponder;


@end