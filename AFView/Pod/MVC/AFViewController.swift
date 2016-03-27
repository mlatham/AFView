import Foundation

public class AFViewController : UIViewController
{
	// MARK: - Properties
	
	private var _visible: Bool
	public var visible: Bool
	{
		get
		{
			return _visible
		}
	}
	
	
	// MARK: - Constructors
	
	public init(nibName: String)
	{
		_visible = false
	
		// TODO: Remove this class post refactor.
		super.init(nibName: nibName, bundle: NSBundle.mainBundle())
	}
	
	public required init?(coder aDecoder: NSCoder)
	{
		_visible = false
	
		super.init(coder: aDecoder)
	}
	
	
	// MARK: - Public Methods

	public override func viewDidAppear(animated: Bool)
	{
		super.viewDidAppear(animated)
		
		// Track visibility.
		_visible = true
	}
	
	public override func viewDidDisappear(animated: Bool)
	{
		super.viewDidDisappear(animated)
		
		// Track visibility.
		_visible = false
	}
}
