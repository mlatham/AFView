
#pragma mark Type Definitions

typedef void (^AFActionSheetCompletion)(id selection);


#pragma mark - Class Interface

@interface AFActionSheet : NSObject


#pragma mark - Static Methods

+ (void)presentFromViewController: (UIViewController *)viewController
	title: (NSString *)title
	otherButtonTitles: (NSArray *)otherButtonTitles
	completion: (AFActionSheetCompletion)completion;


@end
