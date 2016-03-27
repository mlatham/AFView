import Foundation

public typealias AFActionSheetCompletion = (selection: String?) -> Void

public class AFActionSheet : NSObject
{
	// MARK: - Properties
	
	private var _completion: AFActionSheetCompletion? = nil
	private var _options: [String]? = nil
	
	
	// MARK: - Public Methods
	
	public func presentFromViewController(viewController: UIViewController,
		title: String,
		otherButtonTitles: [String],
		completion: AFActionSheetCompletion)
	{
		// Only allow a single call.
		if _completion != nil
		{
			if let completion: AFActionSheetCompletion = completion
			{
				completion(selection: nil)
			}
			return
		}
	
		// Track completion.
		_completion = completion
		
		let alertController: UIAlertController = UIAlertController(title: title,
			message: nil,
			preferredStyle: .ActionSheet)
		
		// Add the cancel button.
		let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel",
			style: .Default,
			handler:
			{ (action) in
			
				// Completion with a nil result.
				if let _completion = self._completion
				{
					_completion(selection: nil)
				}
			})
		
		// Add the action.
		alertController.addAction(cancelAction)
		
		// Add each button title.
		for buttonTitle in otherButtonTitles
		{
			// Create actions for each other buttons.
			let action: UIAlertAction = UIAlertAction(title: buttonTitle,
				style: .Default,
				handler:
				{ (action) in
				
					// Completion with the selected result.
					if let _completion = self._completion
					{
						_completion(selection: buttonTitle)
					}
				})
		
			// Add the action.
			alertController.addAction(action)
		}
		
		// Present the sheet.
		viewController.presentViewController(alertController,
			animated: true,
			completion: nil)
	}
}