#import "UITableView+Universal.h"


#pragma mark Class Definition

@implementation UITableView (Universal)


#pragma mark - Public Methods

- (id)dequeueReusableCellWithCellClass: (Class)cellClass
{
	NSString *className = NSStringFromClass(cellClass);
	
	// Reuse cell if possible (or create one).
	UITableViewCell *cell = [self dequeueReusableCellWithIdentifier: className];
	if (cell == nil)
	{
		cell = cellClass.new;
	}
	
	return cell;
}

- (id)dequeueReusableHeaderFooterViewWithViewClass: (Class)viewClass
{
	NSString *className = NSStringFromClass(viewClass);
	
	// Reuse view if possible (or create one).
	UIView *view = [self dequeueReusableHeaderFooterViewWithIdentifier: className];
	if (view == nil)
	{
		view = viewClass.new;
	}
	
	return view;
}


@end