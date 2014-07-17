

#pragma mark Class Interface

@interface AFKeyboardInfo : NSObject


#pragma mark - Properties

@property (nonatomic, assign, readonly) UIViewAnimationOptions animationCurveAsOptions;
@property (nonatomic, assign, readonly) UIViewAnimationCurve animationCurve;
@property (nonatomic, assign, readonly) NSTimeInterval animationDuration;
@property (nonatomic, assign, readonly) NSDictionary *originalOptions;
@property (nonatomic, assign, readonly) CGRect endFrame;


#pragma mark - Constructors

- (id)initWithEndFrame: (CGRect)endFrame
	animationDuration: (NSTimeInterval)animationDuration
	animationCurve: (UIViewAnimationCurve)animationCurve
	originalOptions: (NSDictionary *)originalOptions;


#pragma mark - Methods

- (void)animate: (void (^)(void))animations;


@end