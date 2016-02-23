import Foundation

public class AFKeyboardObserver : NSObject
{
	// MARK: - Properties
	
	private var _target: AnyObject
	private var _willShowSelector: Selector
	private var _willHideSelector: Selector
	private var _isObservingKeyboardNotifications: Bool

	public var isKeyboardVisible: Bool


	// MARK: - Constructors
	
	public init(target: AnyObject,
		willShowSelector: Selector,
		willHideSelector: Selector)
	{
		// Initialize instance variables.
		_target = target
		_willShowSelector = willShowSelector
		_willHideSelector = willHideSelector
		_isObservingKeyboardNotifications = false
		
		isKeyboardVisible = false
	
		super.init()
	}
	
	
	// MARK: - Destructor
	
	deinit
	{
		// Stop observing.
		if (self._isObservingKeyboardNotifications)
		{
			// Unregister for keyboard notifications.
			NSNotificationCenter.defaultCenter().removeObserver(self,
				name: UIKeyboardWillShowNotification,
				object: nil)
			NSNotificationCenter.defaultCenter().removeObserver(self,
				name: UIKeyboardWillShowNotification,
				object: nil)
			
			// Track whether or not we're observing notifications.
			self._isObservingKeyboardNotifications = false
		}
	}
	
	
	// MARK: - Public Methods

	public func startObserving()
	{
		if (_isObservingKeyboardNotifications)
		{
			return
		}
		
		// Register for keyboard notifications.
		NSNotificationCenter.defaultCenter().addObserver(self,
			selector: _willShowSelector,
			name: UIKeyboardWillShowNotification,
			object: nil)
		NSNotificationCenter.defaultCenter().addObserver(self,
			selector: _willHideSelector,
			name: UIKeyboardWillHideNotification,
			object: nil)
			
		// Track whether or not we're observing notifications.
		_isObservingKeyboardNotifications = true
	}
	
	public func stopObserving()
	{
		if (_isObservingKeyboardNotifications)
		{
			return
		}
		
		// Unregister for keyboard notifications.
		NSNotificationCenter.defaultCenter().removeObserver(self,
			name: UIKeyboardWillShowNotification,
			object: nil)
		NSNotificationCenter.defaultCenter().removeObserver(self,
			name: UIKeyboardWillHideNotification,
			object: nil)
		
		// Track whether or not we're observing notifications.
		_isObservingKeyboardNotifications = false
	}
	
	
	// MARK: - Private Methods
	
	private func _keyboardWillShow(notification: NSNotification)
	{
		// Fire another keyboard will show notification, even if the keyboard is already visible.
		if let userInfo: NSDictionary = notification.userInfo
		{
			// Get the keyboard end frame.
			var endFrame: CGRect = CGRect()
			var duration: NSTimeInterval = 0.1
			var curve: UIViewAnimationCurve = UIViewAnimationCurve.Linear
			
			if let rawEndFrame: NSValue = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSValue
			{
				endFrame = rawEndFrame.CGRectValue()
			}
			
			if let rawDuration: NSNumber = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber
			{
				duration = NSTimeInterval(rawDuration)
			}
			
			if let rawCurve: NSNumber = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
			{
				curve = UIViewAnimationCurve(rawValue: rawCurve.integerValue)!
			}
			
			// Create a keyboard info object to wrap the info.
			let keyboardInfo: AFKeyboardInfo = AFKeyboardInfo(endFrame: endFrame,
				animationDuration: duration,
				animationCurve: curve,
				originalOptions: userInfo)
			
			// Call the callback selector.
			_target.performSelector(_willShowSelector,
				withObject: keyboardInfo)
			
			// Toggle the keyboard visibility.
			self.isKeyboardVisible = true
		}
	}
	
	private func _keyboardWillHide(notification: NSNotification)
	{
		// If the keyboard is not visible, skip this notification.
		if (!self.isKeyboardVisible)
		{
			return
		}
		
		if let userInfo: NSDictionary = notification.userInfo
		{
			// Get the keyboard animation properties.
			var endFrame: CGRect = CGRect()
			var duration: NSTimeInterval = 0.1
			var curve: UIViewAnimationCurve = UIViewAnimationCurve.Linear
			
			if let rawEndFrame: NSValue = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSValue
			{
				endFrame = rawEndFrame.CGRectValue()
			}
			
			if let rawDuration: NSNumber = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber
			{
				duration = NSTimeInterval(rawDuration)
			}
			
			if let rawCurve: NSNumber = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
			{
				curve = UIViewAnimationCurve(rawValue: rawCurve.integerValue)!
			}
			
			// Create a keyboard info object to wrap the info.
			let keyboardInfo: AFKeyboardInfo = AFKeyboardInfo(endFrame: endFrame,
				animationDuration: duration,
				animationCurve: curve,
				originalOptions: userInfo)
			
			// Call the callback selector.
			_target.performSelector(_willHideSelector,
				withObject: keyboardInfo)
			
			// Toggle the keyboard visibility.
			self.isKeyboardVisible = false
		}
	}
}