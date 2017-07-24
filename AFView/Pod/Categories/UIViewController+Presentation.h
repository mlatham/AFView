

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

- (void)presentActionSheetWithTitle: (NSString *)title
	message: (NSString *)message
	preferredStyle: (UIAlertControllerStyle)preferredStyle
	actions: (NSArray *)actions;

- (BOOL)canGoBack;


@end
