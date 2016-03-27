import Foundation

public class AFKeyboardInfo : NSObject
{
	// MARK: - Properties

	public var animationCurveAsOptions: UIViewAnimationOptions
	{
		return AFKeyboardInfo.animationOptionsFromAnimationCurve(self.animationCurve)
	}

	var animationCurve: UIViewAnimationCurve
	var animationDuration: NSTimeInterval
	var originalOptions: NSDictionary
	var endFrame: CGRect


	// MARK: - Constructors

	public init(endFrame: CGRect,
		animationDuration: NSTimeInterval,
		animationCurve: UIViewAnimationCurve,
		originalOptions: NSDictionary)
	{
		// Apply a minimum animation duration.
		if (animationDuration == 0)
		{
			self.animationDuration = 0.2
		}
		else
		{
			self.animationDuration = animationDuration
		}
	
		// Initialize instance variables.
		self.endFrame = endFrame
		self.animationCurve = animationCurve
		self.originalOptions = originalOptions
		
		super.init()
	}


	// MARK: - Public Methods

	public func animate(animations: (() -> ())?)
	{
		// Animate using the keyboard options animation options.
		UIView.beginAnimations(nil,
			context: nil)
		
		// Set the duration.
		if let rawDuration = self.originalOptions[UIKeyboardAnimationDurationUserInfoKey]
		{
			UIView.setAnimationDuration(rawDuration.doubleValue)
		}
		
		// Set the curve.
		if let rawCurve = self.originalOptions[UIKeyboardAnimationCurveUserInfoKey]
		{
			UIView.setAnimationCurve(UIViewAnimationCurve(rawValue: rawCurve.integerValue)!)
		}
		
		UIView.setAnimationBeginsFromCurrentState(true)
		
		// Can be anything.
		if let animations = animations
		{
			animations();
		}
		
		// Commit the animations.
		UIView.commitAnimations()
	}
	
	public static func animationOptionsFromAnimationCurve(animationCurve: UIViewAnimationCurve)
		-> UIViewAnimationOptions
	{
		switch (animationCurve)
		{
			case .EaseInOut:
				return UIViewAnimationOptions.CurveEaseInOut
			case .EaseIn:
				return UIViewAnimationOptions.CurveEaseIn
			case .EaseOut:
				return UIViewAnimationOptions.CurveEaseOut
			case .Linear:
				return UIViewAnimationOptions.CurveLinear
		}
	}
}