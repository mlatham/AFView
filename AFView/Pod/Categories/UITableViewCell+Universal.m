#import "UITableViewCell+Universal.h"
#import "NSBundle+Universal.h"


#pragma mark - Class Definition

@implementation UITableViewCell (Universal)

- (CGFloat)heightConstrainedToTableView: (UITableView *)tableView
	useAutoLayout: (BOOL)useAutoLayout
{
	return [self heightConstrainedToWidth: tableView.frame.size.width
		useAutoLayout: useAutoLayout];
}

- (CGFloat)heightConstrainedToWidth: (CGFloat)width
	useAutoLayout: (BOOL)useAutoLayout
{
	// Update the constraints.
	[self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
	
	// Set the bounds.
	self.bounds = CGRectMake(0.0f, 0.0f, width, CGRectGetHeight(self.bounds));
	
	// Update the layout.
	[self setNeedsLayout];
    [self layoutIfNeeded];
	
	// If the cell supports AutoLayout, use systemLayoutSizeFittingSize.
	if (useAutoLayout == NO)
	{
		CGFloat height = 0.f;
	
		// Size to the cell's subviews.
		for (UIView *subview in self.contentView.subviews)
		{
			if (subview.hidden == NO
				&& subview.frame.origin.y + subview.frame.size.height > height)
			{
				height = subview.frame.origin.y + subview.frame.size.height;
			}
		}
		
		return height;
	}
	else
	{
		// Get the height.
		CGFloat height = [self.contentView systemLayoutSizeFittingSize: UILayoutFittingCompressedSize].height;

		// Add an extra point to the height to account for the cell separator, which is added between the bottom
		// of the cell's contentView and the bottom of the table view cell.
		height += 1.0f;
		
		// Return the height.
		return height;
	}
}


@end