
#pragma mark Type Definitions

typedef void (^AFActionSheetCompletion)(id selection);


#pragma mark - Class Interface

@interface AFActionSheet : NSObject<
	UIActionSheetDelegate>


#pragma mark - Static Methods

- (void)presentInView: (UIView *)view
	title: (NSString *)title
	otherButtonTitles: (NSArray *)otherButtonTitles
	completion: (AFActionSheetCompletion)completion;


@end