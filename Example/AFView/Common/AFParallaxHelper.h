

#pragma mark Class Interface

@interface AFParallaxHelper : NSObject


#pragma mark - Properties

@property (nonatomic, weak, readonly) UIView *target;

@property (nonatomic, assign, readonly) CGPoint restPosition;
@property (nonatomic, assign, readonly) CGPoint restOffset;
@property (nonatomic, assign, readonly) CGPoint multiplier;
@property (nonatomic, assign, readonly) CGPoint maxDelta;
@property (nonatomic, assign, readonly) CGPoint minDelta;

- (void)setViewportOffset: (CGPoint)viewportOffset
	viewportSize: (CGSize)viewportSize;


#pragma mark - Constructors

// "delta" vertical parallax on either side at 0.5 multiplier.
- (id)initWithTarget: (UIView *)target
	maxDelta: (CGPoint)maxDelta
	minDelta: (CGPoint)minDelta;

// 50px vertical parallax on either side at 0.5 multiplier.
- (id)initWithTarget: (UIView *)target
	restOffset: (CGPoint)restOffset;

// Assumes top-aligned rest offset, 50px vertical parallax on either side at 0.5 multiplier.
- (id)initWithTarget: (UIView *)target;

// Designated initializer.
- (id)initWithTarget: (UIView *)target
	restPosition: (CGPoint)restPosition
	restOffset: (CGPoint)restOffset
	maxDelta: (CGPoint)maxDelta
	minDelta: (CGPoint)minDelta
	multiplier: (CGPoint)multiplier;


@end