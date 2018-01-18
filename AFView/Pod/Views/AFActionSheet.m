#import "AFActionSheet.h"


#pragma mark Class Definition

@implementation AFActionSheet
{
	@private __strong AFActionSheetCompletion _completion;
	@private __strong NSArray *_options;
	
	@private NSInteger _cancelButtonIndex;
}


#pragma mark - Public Methods

+ (void)presentFromViewController: (UIViewController *)viewController
	title: (NSString *)title
	otherButtonTitles: (NSArray *)otherButtonTitles
	completion: (AFActionSheetCompletion)completion
{
	// Keep around the completion callback.
	__block AFActionSheetCompletion blockCompletion = [completion copy];

	UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle: title
		message: nil
		preferredStyle: UIAlertControllerStyleActionSheet];

	// TODO: LOCALIZE:
    [actionSheet addAction: [UIAlertAction actionWithTitle: @"Cancel"
    	style: UIAlertActionStyleCancel
		handler: ^(UIAlertAction *action) {
			
			// Call back.
        	[viewController dismissViewControllerAnimated: YES completion: ^{
        		if (blockCompletion != nil)
				{
					blockCompletion(nil);
				}
			}];
    }]];

	// Add each button title.
	for (NSString *buttonTitle in otherButtonTitles)
	{
		[actionSheet addAction: [UIAlertAction actionWithTitle: buttonTitle
			style: UIAlertActionStyleDefault
			handler: ^(UIAlertAction *action) {
				
				// Call back.
	    		[blockCompletion dismissViewControllerAnimated: YES
					completion: ^{
					if (blockCompletion != nil)
					{
						blockCompletion(buttonTitle);
					}
        		}];
    	}]];
	}

    // Present action sheet.
    [viewController presentViewController: actionSheet
		animated: YES
		completion: nil];
}


@end
