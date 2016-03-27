import Foundation

public class AFPageControl : UIControl
{
	// MARK: - Properties
	
	private var _currentPage: Int = 0
	private var _pages: [UIImageView] = []
	private var _pageContainer: UIControl? = nil
	private var _dotImages: Dictionary<String, UIImage> = [:]
	
	public var currentPage: Int
	{
		set
		{
			_updateCurrentPage(newValue, raiseEvent: true)
		}
		get
		{
			return _currentPage
		}
	}
	
	public var numberOfPages: Int
	{
		set
		{
			_updatePageCount(newValue, raiseEvent: true)
		}
		get
		{
			return _pages.count
		}
	}
	
	
	// MARK: - Constructors
	
	public override init(frame: CGRect)
	{
		super.init(frame: frame)
		
		_initialize()
	}
	
    public required init?(coder aDecoder: NSCoder)
	{
		super.init(coder: aDecoder)
		
		_initialize()
	}
	
	
	// MARK: - Public Methods
	
	public func setDotImage(dotImage: UIImage, controlState: UIControlState)
	{
		_dotImages[_keyForControlState(controlState)] = dotImage
	}
	
	public func dotImage(controlState: UIControlState) -> UIImage?
	{
		return _dotImages[_keyForControlState(controlState)]
	}
	
	public func coerceCurrentPage(currentPage: Int)
	{
		_updateCurrentPage(currentPage, raiseEvent: false)
	}
	
	public func coercePageCount(numberOfPages: Int)
	{
		_updatePageCount(numberOfPages, raiseEvent: false)
	}
	
	
	// MARK: - Private Methods
	
	public func _pageContainerTouched(sender: UIView, event: UIEvent?)
	{
		if let event = event
		{
			if let _pageContainer = _pageContainer
			{
				if let touch = event.touchesForView(_pageContainer)?.first as UITouch?
				{
					// Resolve touch position.
					let touchPoint: CGPoint = touch.locationInView(_pageContainer)
					
					// Determine page touched.
					let pagePercent: Float = Float(touchPoint.x / _pageContainer.frame.size.width)
					let pageIndex: Int = Int(pagePercent * Float(_pages.count))
					
					// Update the current page.
					self.currentPage = pageIndex
				}
			}
		}
	}
	
	private func _keyForControlState(controlState: UIControlState) -> String
	{
		var result: String = "UIControlStateNormal"
		
		switch controlState
		{
			case UIControlState.Highlighted:
				result = "UIControlStateHighlighted"
				break
		
			case UIControlState.Normal:
				result = "UIControlStateNormal"
				break
			
			default:
				break
		}
		
		return result
	}
	
	private func _updatePageCount(numberOfPages: Int, raiseEvent: Bool)
	{
		// Skip if value is unchanged.
		var pageCount: Int = _pages.count
		if numberOfPages == pageCount
		{
			return
		}
		
		// Delete previous pages.
		_pages.removeAll()
		
		// Unbind page container.
		if let _pageContainer = self._pageContainer
		{
			// Unwire events.
			_pageContainer.removeTarget(self,
				action: #selector(_pageContainerTouched(_:event:)),
				forControlEvents: .TouchDown)
			
			// Delete page container.
			_pageContainer.removeFromSuperview()
			self._pageContainer = nil
		}
		
		// Skip if page count is zero.
		pageCount = numberOfPages
		if pageCount == 0
		{
			_currentPage = 0
			return
		}
		
		// Create page container.
		if let dotNormalImage = _dotNormalImage()
		{
			let pageMargin: CGFloat = round(dotNormalImage.size.width * 2.0 / 3.0)
			let pageSize: CGSize = dotNormalImage.size
			let frame: CGRect = self.frame
			let pageContainerWidth: CGFloat = (pageMargin * (CGFloat(pageCount) + 1)) + (pageSize.width * CGFloat(pageCount))
			
			_pageContainer = UIControl(frame: CGRect(
				x: round((frame.size.width - pageContainerWidth) / 2.0),
				y: 0,
				width: pageContainerWidth,
				height: frame.size.height))
			
			// Create new pages.
			var pageFrame: CGRect = CGRect(
				x: pageMargin,
				y: round(frame.size.height - pageSize.height) / 2,
				width: pageSize.width,
				height: pageSize.height)
			
			for _ in 0...pageCount
			{
				let page: UIImageView = UIImageView(frame: pageFrame)
				page.contentMode = UIViewContentMode.Center
				page.highlightedImage = _dotHighlightImage()
				page.image = _dotNormalImage()
			
				// Bind page.
				_pageContainer?.addSubview(page)
				_pages.append(page)
				
				// Update page frame.
				pageFrame.origin.x = pageFrame.origin.x + pageSize.width + pageMargin
			}
			
			// Add page container to view.
			if let _pageContainer = _pageContainer
			{
				self.addSubview(_pageContainer)
			}
			
			// Wire events.
			_pageContainer?.addTarget(self,
				action: #selector(_pageContainerTouched(_:event:)),
				forControlEvents: .TouchDown)
			_pageContainer?.opaque = false
			_pageContainer?.backgroundColor = UIColor.clearColor()
			_pageContainer?.userInteractionEnabled = true
			
			// Update page.
			_currentPage = -1
			_updateCurrentPage(0,
				raiseEvent: raiseEvent)
		}
	}
	
	private func _updateCurrentPage(currentPage: Int, raiseEvent: Bool)
	{
		// Normalize value.
		let pageCount: Int = _pages.count
		let currentPage = max(0, min(currentPage, pageCount - 1))
		
		// Track if page actually changed.
		let pageChanged: Bool = _currentPage != currentPage
		
		// Remove highlight from previous page.
		if _currentPage < pageCount
		{
			let page: UIImageView = _pages[_currentPage]
			page.highlighted = false
		}
		
		// Set highlight on new page.
		_currentPage = currentPage
		let page: UIImageView = _pages[_currentPage]
		page.highlighted = true
		
		// Raise value changed event (if required)
		if pageChanged && raiseEvent
		{
			self.sendActionsForControlEvents(UIControlEvents.ValueChanged)
		}
	}
	
	private func _dotNormalImage() -> UIImage?
	{
		return dotImage(UIControlState.Normal)
	}
	
	private func _dotHighlightImage() -> UIImage?
	{
		return dotImage(UIControlState.Highlighted)
	}
	
	private func _initialize()
	{
		self.opaque = false
		self.backgroundColor = UIColor.blackColor()
	}
}
