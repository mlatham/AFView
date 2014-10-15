#import "UIKit/UIKit.h"


#pragma mark Class Interface

@interface UITableViewCell (Universal)


#pragma mark - Properties

// Whether or not this cell was returned from a call to [UITableViewCell templateCellWithClassName:]
@property (nonatomic, assign) BOOL isTemplate;


#pragma mark - Instance Methods

// Lays out this cell's subviews and returns the height that fits the provided width.

- (CGFloat)heightConstrainedToTableView: (UITableView *)tableView
	useAutoLayout: (BOOL)useAutoLayout;

- (CGFloat)heightConstrainedToWidth: (CGFloat)width
	useAutoLayout: (BOOL)useAutoLayout;


@end