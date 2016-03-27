import Foundation

extension UIView
{
	// MARK: - Type Aliases
	
	public typealias UIViewResignationBlock = (Void) -> Void


	// MARK: - Public Methods

	public static func findFirstResponder()
		-> UIView?
	{
		let mainView: UIView? = UIApplication.sharedApplication().keyWindow
		return mainView?.findFirstResponder()
	}
	
	public static func resignFirstResponder(completion: UIViewResignationBlock)
	{
		let firstResponder: UIView? = UIView.findFirstResponder()
		
		if firstResponder != nil
		{
			firstResponder?.resignFirstResponder()
			
			// CLUDGE: Call the block after a delay.
			_delay(0.3, closure: completion)
		}
		else
		{
			// Call completion, if provided.
			completion()
		}
	}
	
	public func findFirstResponder()
		-> UIView?
	{
		// Return once the first responder is found.
		if self.isFirstResponder()
		{
			return self
		}
		
		// Recursively search subviews.
		for subview in self.subviews
		{
			let firstResponder: UIView? = subview.findFirstResponder()
			
			if firstResponder != nil
			{
				return firstResponder
			}
		}
		
		return nil
	}
	
	// MARK: - Private Methods
	
	private static func _delay(delay: Double, closure: ()->())
	{
		dispatch_after(
			dispatch_time(
				DISPATCH_TIME_NOW,
				Int64(delay * Double(NSEC_PER_SEC))
			),
			dispatch_get_main_queue(),
			closure)
	}
}