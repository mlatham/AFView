#import "AFActionSheet.h"


#pragma mark Class Definition

@implementation AFActionSheet
{
	@private __strong AFActionSheetCompletion _completion;
	@private __strong NSArray *_options;
	
	@private NSInteger _cancelButtonIndex;
}


#pragma mark - UIActionSheetDelegate Methods

- (void)actionSheet: (UIActionSheet *)actionSheet
	clickedButtonAtIndex: (NSInteger)buttonIndex
{
	id result = nil;
	
	if (buttonIndex == actionSheet.destructiveButtonIndex)
	{
		NSAssert(NO, @"Destructive button unsupported");
	}
	else if (buttonIndex == actionSheet.cancelButtonIndex)
	{
		// Result is nil.
	}
	else if (buttonIndex >= actionSheet.firstOtherButtonIndex)
	{
		buttonIndex -= actionSheet.firstOtherButtonIndex;
		result = [_options objectAtIndex: buttonIndex];
	}

	// Call and clear the completion.
	if (_completion != nil)
	{
		_completion(result);
		_completion = nil;
	}
}


#pragma mark - Public Methods

- (void)presentInView: (UIView *)view
	title: (NSString *)title
	otherButtonTitles: (NSArray *)otherButtonTitles
	completion: (AFActionSheetCompletion)completion
{
	// Only allow a single call.
	if (_completion != nil)
	{
		completion(nil);
		return;
	}
	
	// Track completion.
	_completion = [completion copy];

	// Show action sheet.
	UIActionSheet *actionSheet = [[UIActionSheet alloc]
		initWithTitle: title
		delegate: self
		cancelButtonTitle: @"Cancel" // TODO: LOCALIZE:
		destructiveButtonTitle: nil
		otherButtonTitles: nil];
		
	// Add each button title.
	for (NSString *buttonTitle in otherButtonTitles)
	{
		[actionSheet addButtonWithTitle: buttonTitle];
	}
		
	actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
	
	// Present the sheet.
	[actionSheet showInView: view];
}


@end