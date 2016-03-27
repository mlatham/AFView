import Foundation

extension UIScrollView
{
	// MARK: - Properties

	private static let MARGIN: CGFloat = 8;
	
	private struct AssociatedKeys
	{
        static var CachedBottomContentInsetKey = "UIScrollView.ScrollToView"
    }
	
	var cachedBottomContentInset: NSNumber?
	{
		get
		{
			return objc_getAssociatedObject(self, &AssociatedKeys.CachedBottomContentInsetKey) as? NSNumber
		}
		set (value)
		{
			objc_setAssociatedObject(self, &AssociatedKeys.CachedBottomContentInsetKey, value, .OBJC_ASSOCIATION_RETAIN)
		}
	}
	

	// MARK: - Public Methods

	public func scrollToView(view: UIView,
		duration: NSTimeInterval,
		animationCurve: UIViewAnimationCurve,
		bottomInset: CGFloat)
	{
		// Set the cached bottom content inset, to allow resetting it later.
		if (cachedBottomContentInset == nil)
		{
			self.cachedBottomContentInset = NSNumber(float: Float(self.contentInset.bottom))
		}
		
		var contentInset: UIEdgeInsets = self.contentInset
		contentInset.bottom = bottomInset
		
		var contentSpacePoint: CGPoint = view.superview!.convertPoint(view.frame.origin,
			toView: self)
		
		// Send the point on its mystical journey.
		contentSpacePoint.y -= UIScrollView.MARGIN
		
		let screenSpacePoint: CGPoint = CGPoint(x: 0, y: contentSpacePoint.y - self.contentOffset.y)
		
		let screenMaxY: CGFloat = self.frame.size.height - bottomInset - view.frame.size.height - UIScrollView.MARGIN
		let screenMinY: CGFloat = 0
		
		if (screenSpacePoint.y < screenMinY)
		{
			UIView.beginAnimations(nil, context: nil)
			UIView.setAnimationDuration(duration)
			UIView.setAnimationCurve(animationCurve)
			
			// Animations.
			self.contentOffset = CGPoint(x: 0, y: contentSpacePoint.y)
			self.contentInset = contentInset
		}
		else if (screenSpacePoint.y > screenMaxY)
		{
			// Determine the content offset that sits right below the keyboard.
			contentSpacePoint.y = contentSpacePoint.y - screenMaxY + UIScrollView.MARGIN
			
			UIView.beginAnimations(nil, context: nil)
			UIView.setAnimationDuration(duration)
			UIView.setAnimationCurve(animationCurve)
			
			self.contentOffset = CGPoint(x: 0, y: contentSpacePoint.y);
			self.contentInset = contentInset;
		
			UIView.commitAnimations();
		}
	}
	
	public func scrollToView(view: UIView,
		duration: NSTimeInterval,
		options: UIViewAnimationOptions,
		bottomInset: CGFloat)
	{
		// Set the cached bottom content inset, to allow resetting it later.
		if (cachedBottomContentInset == nil)
		{
			self.cachedBottomContentInset = NSNumber(float: Float(self.contentInset.bottom))
		}
		
		var contentInset: UIEdgeInsets = self.contentInset
		contentInset.bottom = bottomInset
		
		var contentSpacePoint: CGPoint = view.superview!.convertPoint(view.frame.origin,
			toView: self)
		
		// Send the point on its mystical journey.
		contentSpacePoint.y -= UIScrollView.MARGIN
		
		let screenSpacePoint: CGPoint = CGPoint(x: 0, y: contentSpacePoint.y - self.contentOffset.y)
		
		let screenMaxY: CGFloat = self.frame.size.height - bottomInset - view.frame.size.height - UIScrollView.MARGIN
		let screenMinY: CGFloat = 0

		if (screenSpacePoint.y < screenMinY)
		{
			UIView.animateWithDuration(duration,
				delay: 0,
				options: options,
				animations:
				{ () -> Void in
					self.contentOffset = CGPoint(x: 0, y: contentSpacePoint.y)
				},
				completion:
				{ (finished) -> Void in
					self.contentInset = contentInset
				})
		}
		else if (screenSpacePoint.y > screenMaxY)
		{
			// Determine the content offset that sits right below the keyboard.
			contentSpacePoint.y = contentSpacePoint.y - screenMaxY + UIScrollView.MARGIN;
			
			UIView.animateWithDuration(duration,
				delay: 0,
				options: options,
				animations:
				{ () -> Void in
					self.contentOffset = CGPoint(x: 0, y: contentSpacePoint.y)
				},
				completion:
				{ (finished) -> Void in
					self.contentInset = contentInset
				})
		}
	}
	
	public func scrollToView(view: UIView,
		keyboardInfo: AFKeyboardInfo)
	{
		self.scrollToView(view,
			duration: keyboardInfo.animationDuration,
			animationCurve: keyboardInfo.animationCurve,
			bottomInset: keyboardInfo.endFrame.size.height)
	}
	
	public func scrollToFirstResponder(keyboardInfo: AFKeyboardInfo)
	{
		let view: UIView? = UIWindow.findFirstResponder()
		
		if let view = view
		{
			self.scrollToView(view,
				keyboardInfo: keyboardInfo)
		}
	}
	
	public func clearBottomInset(duration: NSTimeInterval,
		options: UIViewAnimationOptions)
	{
		var contentInset: UIEdgeInsets = self.contentInset
		contentInset.bottom = 0
		
		// Get the cached bottom content inset.
		let bottom = self.cachedBottomContentInset
		
		// Apply the cached bottom content inset, if set.
		if let bottom = bottom
		{
			contentInset.bottom = CGFloat(bottom.floatValue)
			
			// Unset the cached copy.
			self.cachedBottomContentInset = nil
		}
		
		UIView.animateWithDuration(duration,
			delay: 0,
			options: options,
			animations:
			{
				self.contentInset = contentInset
			},
			completion: nil)
	}
	
	public func sizeToFitContent()
	{
		var height: CGFloat = 0
		
		for view in self.subviews
		{
			// Only take into account visible views.
			if !view.hidden
			{
				let position: CGFloat = view.frame.size.height + view.frame.origin.y
				
				if (position > height)
				{
					height = position
				}
			}
		}
		
		var contentSize: CGSize = self.contentSize
		contentSize.height = height
		self.contentSize = contentSize
	}
}