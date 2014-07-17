

#pragma mark Class Interface

@interface UIViewController (Presentation)


#pragma mark - Instance Methods

- (void)pushViewController: (UIViewController *)viewController
	clearBackStack: (BOOL)clearBackStack;

- (void)pushViewController: (UIViewController *)viewController;

- (void)presentViewController: (UIViewController *)viewController;

- (void)presentViewController:(UIViewController *)viewController
	inNavigationControllerWithClass: (Class)navigationControllerClass;

- (void)presentViewController: (UIViewController *)viewController
	inNavigationControllerWithClass: (Class)navigationControllerClass
	animated: (BOOL)animated
	completion: (void (^)(void))completion;

- (BOOL)canGoBack;


@end