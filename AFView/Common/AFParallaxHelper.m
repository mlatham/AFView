#import "AFParallaxHelper.h"


#pragma mark Class Definition

@implementation AFParallaxHelper
{
	@private CGPoint _viewportOffset;
	@private CGSize _viewportSize;
}


#pragma mark - Properties

- (void)setViewportOffset: (CGPoint)viewportOffset
	viewportSize: (CGSize)viewportSize
{
	_viewportOffset = viewportOffset;
	_viewportSize = viewportSize;
	
	// Determine the distance between the pivot and the viewport center.
	CGFloat yDelta = viewportOffset.y - _restOffset.y; // 100 - 0 = 100 (values ascend as viewport descends lower than the pivot).
	CGFloat xDelta = viewportOffset.x - _restOffset.x;
	
	CGFloat yRaw = yDelta * _multiplier.y;
	CGFloat xRaw = xDelta * _multiplier.x;
	
	// Calculate the parallax offset.
	CGFloat yFinal = _restPosition.y - MIN(MAX(yRaw, _minDelta.y), _maxDelta.y);
	CGFloat xFinal = _restPosition.x - MIN(MAX(xRaw, _minDelta.x), _maxDelta.x);
	
	CGFloat scale = 1.f;
	
	// If the viewport offset exceeds the max, scale the target.
	if (yRaw <= _minDelta.y)
	{
		CGFloat yScale = MAX(_minDelta.y, 100.f);
	
		scale += fabs(yRaw - _minDelta.y) / fabs(yScale);
	}
	
	// Scale the target.
	_target.layer.anchorPoint = CGPointMake(0.5f, 1.0f);
	[_target.layer setValue: [NSNumber numberWithFloat: scale]
		forKeyPath: @"transform.scale"];
	
	// Set the updated position.
	CGPoint position = _target.layer.position;
	position.y = yFinal + (_target.layer.bounds.size.height / 2.f);
	if (_minDelta.x != 0.f || _maxDelta.x != 0.f)
	{
		position.x = xFinal;
	}
	_target.layer.position = position;
}


#pragma mark - Constructors

- (id)initWithTarget: (UIView *)target
	maxDelta: (CGPoint)maxDelta
	minDelta: (CGPoint)minDelta
{
	return [self initWithTarget: target
		restPosition: CGPointMake(target.layer.position.x, target.layer.position.y)
		restOffset: CGPointMake(0.f, 0.f)
		maxDelta: maxDelta
		minDelta: minDelta
		multiplier: CGPointMake(0.f, 0.5f)];
}

- (id)initWithTarget: (UIView *)target
	restOffset: (CGPoint)restOffset
{
	return [self initWithTarget: target
		restPosition: CGPointMake(target.layer.position.x, target.layer.position.y)
		restOffset: restOffset
		maxDelta: CGPointMake(0.f, 50.f)
		minDelta: CGPointMake(0.f, -50.f)
		multiplier: CGPointMake(0.f, 0.5f)];
}

- (id)initWithTarget: (UIView *)target
{
	return [self initWithTarget: target
		restOffset: CGPointMake(0.f, 0.f)];
}

- (id)initWithTarget: (UIView *)target
	restPosition: (CGPoint)restPosition
	restOffset: (CGPoint)restOffset
	maxDelta: (CGPoint)maxDelta
	minDelta: (CGPoint)minDelta
	multiplier: (CGPoint)multiplier
{
	// Abort if base initializer fails.
	if ((self = [super init]) == nil)
	{
		return nil;
	}
	
	// Initialize instance variables.
	_target = target;
	_restPosition = restPosition;
	_restOffset = restOffset;
	_maxDelta = maxDelta;
	_minDelta = minDelta;
	_multiplier = multiplier;
	
	// Return initialized instance.
	return self;
}


@end