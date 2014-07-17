#import "UIView+ViewController.h"


#pragma mark Class Definition

@implementation UIView (ViewController)


#pragma mark - Public Methods

- (void)pushViewController: (UIViewController *)viewController
{
	// Push the view controller.
	[self pushViewController: viewController
		animated: YES];
}

- (void)pushViewController: (UIViewController *)viewController
	animated: (BOOL)animated
{
	// Get the first available view controller.
	UIViewController *firstAvailableController = self.firstAvailableViewController;
	
	// Get the view controller's navigation controller.
	UINavigationController *navigationController = firstAvailableController.navigationController;
	
	// Push the view controller.
	[navigationController pushViewController: viewController
		animated: YES];
}

- (void)presentViewController: (UIViewController *)viewController
{
	[self presentViewController: viewController
		inNavigationControllerWithClass: nil
		animated: YES
		completion: nil];
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
	// Get the first available view controller.
	UIViewController *firstAvailableController = self.firstAvailableViewController;
	
	if (navigationControllerClass != nil)
	{
		// This code is convenient, but be careful when providing a Class to this method.
		// It must implement initWithRootViewController - ie be a UIViewController subclass.
		id navigationController = [[navigationControllerClass alloc]
			initWithRootViewController: viewController];
		viewController = navigationController;
	}
	
	// Present the view controller.
	[firstAvailableController presentViewController: viewController
		animated: animated
		completion: completion];
}

- (UIViewController *)firstAvailableViewController
{
    return (UIViewController *)[self _traverseResponderChainForViewControllerFrom: self];
}


#pragma mark - Private Methods

- (id)_traverseResponderChainForViewControllerFrom: (UIResponder *)responder
{
	id nextResponder = [self nextResponder];
	
	if (nextResponder != nil)
	{
		if ([nextResponder isKindOfClass: [UIViewController class]])
		{
			return nextResponder;
		}
		else
		{
			return [nextResponder _traverseResponderChainForViewControllerFrom: nextResponder];
		}
	}
	
	return nil;
}


@end