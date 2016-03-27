import Foundation

public class AFSegmentButton : UIButton
{
	// MARK: - Properties
	
	private var _backgroundHidden: Bool = false
	private var _keyline: UIImageView?
	
	public var backgroundHidden: Bool
	{
		set
		{
			_backgroundHidden = newValue
			
			_keyline?.y = backgroundHidden ? 0.0 : 3.0
			_keyline?.height = backgroundHidden
				? self.frame.size.height
				: self.frame.size.height - 3.0 * 2.0
		}
		get
		{
			return _backgroundHidden
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
	
	
	// MARK: - Private Methods
	
	private func _initialize()
	{
		// Allow titles to wrap.
		self.titleLabel?.numberOfLines = 0
		self.titleLabel?.textAlignment = .Center
		
		// Add the right keyline.
		_keyline = UIImageView(frame: CGRectMake(0.0, 0.0, 1.0, self.frame.size.height))
		_keyline!.autoresizingMask = [ .FlexibleHeight, .FlexibleWidth ]
		self.addSubview(_keyline!)
	}
}