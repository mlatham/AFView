

#pragma mark Class Interface

@interface UIView (ViewController)


#pragma mark - Instance Methods

- (void)pushViewController: (UIViewController *)viewController;

- (void)pushViewController: (UIViewController *)viewController
	animated: (BOOL)animated;

- (void)presentViewController: (UIViewController *)viewController;

- (void)presentViewController:(UIViewController *)viewController
	inNavigationControllerWithClass: (Class)navigationControllerClass;

- (void)presentViewController:(UIViewController *)viewController
	inNavigationControllerWithClass: (Class)navigationControllerClass
	hideNavigationBar: (BOOL)hideNavigationBar;

- (void)presentViewController: (UIViewController *)viewController
	inNavigationControllerWithClass: (Class)navigationControllerClass
	hideNavigationBar: (BOOL)hideNavigationBar
	animated: (BOOL)animated
	completion: (void (^)(void))completion;

- (UIViewController *)firstAvailableViewController;


@end