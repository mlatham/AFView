#import "UIKit/UIKit.h"


#pragma mark Class Interface

@interface UITableViewCell (Universal)


#pragma mark - Instance Methods

// Lays out this cell's subviews and returns the height that fits the provided width.

- (CGFloat)heightConstrainedToTableView: (UITableView *)tableView
	useAutoLayout: (BOOL)useAutoLayout;

- (CGFloat)heightConstrainedToWidth: (CGFloat)width
	useAutoLayout: (BOOL)useAutoLayout;


@end