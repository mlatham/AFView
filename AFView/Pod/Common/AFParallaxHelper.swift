import Foundation

public class AFParallaxHelper : NSObject
{
	// MARK: - Properties
	
	private var _viewportOffset: CGPoint
	private var _viewportSize: CGSize
	
	weak var target: UIView?
	
	var restPosition: CGPoint
	var restOffset: CGPoint
	var multiplier: CGPoint
	var maxDelta: CGPoint
	var minDelta: CGPoint

	public func setViewportOffset(viewportOffset: CGPoint, viewportSize: CGSize)
	{
		_viewportOffset = viewportOffset
		_viewportSize = viewportSize
		
		// Determine the distance between the pivot and the viewport center.
		let yDelta: CGFloat = viewportOffset.y - restOffset.y // 100 - 0 = 100 (values ascend as viewport descends lower than the pivot).
		let xDelta: CGFloat = viewportOffset.x - restOffset.x
		
		let yRaw: CGFloat = yDelta * multiplier.y
		let xRaw: CGFloat = xDelta * multiplier.x
		
		// Calculate the parallax offset.
		let yFinal: CGFloat = restPosition.y - min(max(yRaw, minDelta.y), maxDelta.y)
		let xFinal: CGFloat = restPosition.x - min(max(xRaw, minDelta.x), maxDelta.x)
		
		var scale: CGFloat = 1.0
		
		// If the viewport offset exceeds the max, scale the target.
		if (yRaw <= minDelta.y)
		{
			let yScale: CGFloat = max(minDelta.y, 100)
			
			scale += fabs(yRaw - minDelta.y) / fabs(yScale)
		}
		
		let scaleValue: NSNumber? = NSNumber(float: Float(scale))
		
		if let target = target
		{
			// Scale the target.
			target.layer.anchorPoint = CGPoint(x: 0.5, y: 1.0)
			target.layer.setValue(scaleValue, forKey: "transform.scale")

			// Set the updated position.
			var position: CGPoint = target.layer.position
			position.y = yFinal + target.layer.bounds.size.height / 2.0
			if (minDelta.x != 0 || maxDelta.x != 0)
			{
				position.x = xFinal
			}
			target.layer.position = position
			
			// Force re-layout after making these changes.
			target.setNeedsLayout()
			target.layoutIfNeeded()
		}
	}
	
	
	// MARK: - Constructors
	
	public convenience init(target: UIView,
		maxDelta: CGPoint,
		minDelta: CGPoint)
	{
		self.init(target: target,
			restPosition: CGPoint(x: target.layer.position.x, y: target.layer.position.y),
			restOffset: CGPoint(x: 0, y: 0),
			maxDelta: maxDelta,
			minDelta: minDelta,
			multiplier: CGPoint(x: 0, y: 0.5))
	}
	
	public convenience init(target: UIView,
		restOffset: CGPoint)
	{
		self.init(target: target,
			restPosition: CGPoint(x: target.layer.position.x, y: target.layer.position.y),
			restOffset: CGPoint(x: 0, y: 0),
			maxDelta: CGPoint(x: 0, y: 50),
			minDelta: CGPoint(x: 0, y: -50),
			multiplier: CGPoint(x: 0, y: 0.5))
	}
	
	public convenience init(target: UIView)
	{
		self.init(target: target, restOffset: CGPoint(x: 0.0, y: 0.0))
	}
	
	public init(target: UIView,
		restPosition: CGPoint,
		restOffset: CGPoint,
		maxDelta: CGPoint,
		minDelta: CGPoint,
		multiplier: CGPoint)
	{
		// Initialize instance variables.
		self.target = target
		self.restPosition = restPosition
		self.restOffset = restOffset
		self.maxDelta = maxDelta
		self.minDelta = minDelta
		self.multiplier = multiplier
		
		_viewportSize = CGSize(width: 0, height: 0)
		_viewportOffset = CGPoint(x: 0, y: 0)
	
		super.init()
	}
}