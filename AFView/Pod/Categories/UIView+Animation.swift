import Foundation

extension UIView
{
	// MARK: - Static Methods
	
	/**
	 * Animates using the provided blocks if "animate" is true,
	 * otherwise simply calls animations, then completion blocks.
	 */
	public static func animate(animate: Bool,
		duration: NSTimeInterval,
		delay: NSTimeInterval,
		options: UIViewAnimationOptions,
		animations: () -> (),
		completion: ((Bool) -> ())?)
	{
		if (animate)
		{
			// Animate change.
			UIView.animateWithDuration(duration,
				delay: delay,
				options: options,
				animations: animations,
				completion: completion)
		}
		else
		{
			// Explicitly apply the change.
			animations()
			
			// Call completion, if provided.
			if let completion = completion
			{
				completion(true)
			}
		}
	}
	
	/**
	 * Animates using the provided blocks if "animate" is true,
	 * otherwise simply calls animations, then completion blocks.
	 */
	public static func animate(animate: Bool,
		duration: NSTimeInterval,
		delay: NSTimeInterval,
		damping: CGFloat,
		initialSpringVelocity: CGFloat,
		options: UIViewAnimationOptions,
		animations: () -> (),
		completion: ((Bool) -> ())?)
	{
		if (animate)
		{
			// Animate change.
			UIView.animateWithDuration(duration,
				delay: delay,
				usingSpringWithDamping: damping,
				initialSpringVelocity: initialSpringVelocity,
				options: options,
				animations: animations,
				completion: completion)
		}
		else
		{
			// Explicitly apply change, if provided.
				animations()
			
			// Call completion, if provided.
			if let completion = completion
			{
				completion(true)
			}
		}
	}
	
	
	// MARK: - Public Methods

	/**
	 * Shakes this view.
	 */
	public func shake()
	{
		let t: CGFloat = 2.0
	
		let translateRight: CGAffineTransform = CGAffineTransformTranslate(CGAffineTransformIdentity, t, 0.0)
		let translateLeft: CGAffineTransform = CGAffineTransformTranslate(CGAffineTransformIdentity, -t, 0.0)

		self.transform = translateLeft

		UIView.animateWithDuration(0.07,
			delay: 0.0,
			options: [UIViewAnimationOptions.Autoreverse, UIViewAnimationOptions.Repeat],
			animations:
			{
				() -> Void in
				
				UIView.setAnimationRepeatCount(2.0)
				
				self.transform = translateRight
			},
			completion:
			{
				(finished) -> Void in
			
				if (finished)
				{
					UIView.animateWithDuration(0.05,
						delay: 0.0,
						options: UIViewAnimationOptions.BeginFromCurrentState,
						animations:
						{
							() -> Void in
						
							self.transform = CGAffineTransformIdentity
						},
						completion: nil)
				}
			})
	}
}