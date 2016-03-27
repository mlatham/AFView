import Foundation

extension UIView
{
	// MARK: - Properties

	public var x: CGFloat
	{
		get
		{
			let x = self.center.x - (self.width / 2.0)
			return x
		}
		set
		{
			var viewCenter = self.center
			
			// Floor the x origin to avoid subpixel rendering.
			viewCenter.x = floor(x) + (self.width / 2.0)
			
			self.center = viewCenter
		}
	}
	
	public var y: CGFloat
	{
		get
		{
			let y = self.center.y - (self.height / 2.0)
			return y
		}
		set
		{
			var viewCenter = self.center
			
			// Floor the x origin to avoid subpixel rendering.
			viewCenter.y = floor(y) + (self.height / 2.0)
			
			self.center = viewCenter
		}
	}
	
	public var width: CGFloat
	{
		get
		{
			let width = self.bounds.size.width
			return width
		}
		set
		{
			// Changing the width of a view through its bounds updates the view's x origin
			// so it needs to be set again after the the bounds have been changed.
			let previousX = self.x
			
			var viewBounds = self.bounds
			
			// Floor the width to avoid subpixel rendering.
			viewBounds.size.width = floor(width)
			
			self.bounds = viewBounds
			
			self.x = previousX
		}
	}
	
	public var height: CGFloat
	{
		get
		{
			let height = self.bounds.size.height
			return height
		}
		set
		{
			// Changing the height of a view through its bounds updates the view's y origin
			// so it needs to be set again after the the bounds have been changed.
			let previousY = self.y;

			var viewBounds = self.bounds;

			// Floor the height to avoid subpixel rendering.
			viewBounds.size.height = floor(height);

			self.bounds = viewBounds;

			self.y = previousY;
		}
	}
}