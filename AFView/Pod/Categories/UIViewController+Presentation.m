#import "UIViewController+Presentation.h"


#pragma mark Class Definition

@implementation UIViewController (Presentation)


#pragma mark - Public Methods

- (void)pushViewController: (UIViewController *)viewController
	clearBackStack: (BOOL)clearBackStack
{
	UINavigationController *navigationController = nil;
	
	// Get the navigation controller.
	if ([self isKindOfClass: [UINavigationController class]])
	{
		navigationController = (UINavigationController *)self;
	}
	else
	{
		navigationController = self.navigationController;
	}

	// Get the view controller's navigation controller.
	NSAssert(navigationController != nil, @"Expected a navigation controller");

	// Push the view controller.
	[self pushViewController: viewController];

	NSArray *vcs = navigationController.viewControllers;
	
	// Clear the back stack.
	if ([vcs count] > 0)
	{
		NSMutableArray *trimmedViewControllers = [NSMutableArray array];
		[trimmedViewControllers addObject: [vcs objectAtIndex: 0]];
		[trimmedViewControllers addObject: [vcs objectAtIndex: [vcs count] - 1]];
		navigationController.viewControllers = trimmedViewControllers;
	}
}

- (void)pushViewController: (UIViewController *)viewController
{
	if ([self isKindOfClass: [UINavigationController class]])
	{
		UINavigationController *navigationController = (UINavigationController *)self;
		
		[navigationController pushViewController: viewController
			animated: YES];
	}
	else
	{
		[self.navigationController pushViewController: viewController
			animated: YES];
	}
}

- (void)presentViewController: (UIViewController *)viewController
{
	[self presentViewController: viewController
		inNavigationControllerWithClass: nil];
}

- (void)presentViewController:(UIViewController *)viewController
	inNavigationControllerWithClass: (Class)navigationControllerClass
{
	[self presentViewController: viewController
		inNavigationControllerWithClass: navigationControllerClass
		animated: YES
		completion: nil];
}

- (void)presentViewController: (UIViewController *)viewController
	inNavigationControllerWithClass: (Class)navigationControllerClass
	animated: (BOOL)animated
	completion: (void (^)(void))completion
{
	if (navigationControllerClass != nil)
	{
		// This code is convenient, but be careful when providing a Class to this method.
		// It must implement initWithRootViewController - ie be a UIViewController subclass.
		id navigationController = [[navigationControllerClass alloc]
			initWithRootViewController: viewController];
		viewController = navigationController;
	}
	
	// Present the view controller.
	[self presentViewController: viewController
		animated: animated
		completion: completion];
}

- (void)presentActionSheetWithTitle: (NSString *)title
	message: (NSString *)message
	preferredStyle: (UIAlertControllerStyle)preferredStyle
	actions: (NSArray *)actions
{
	UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle: title
		message: message
		preferredStyle: preferredStyle];

	for (UIAlertAction *action in actions)
	{
		[actionSheet addAction: action];
	}
	
	// Present the action sheet.
    [self presentViewController: actionSheet animated: YES completion: nil];
}

- (BOOL)canGoBack
{
	BOOL canGoBack = NO;

	// Determine if this is the top level view controller in the UINavigationController stack.
	if (self.navigationController != nil
		&& [self.navigationController.viewControllers indexOfObject: self] > 0)
	{
		canGoBack = YES;
	}
	
	return canGoBack;
}


@end
