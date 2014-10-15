#import "UITableView+Universal.h"
#import "UITableViewCell+Universal.h"
#import <objc/runtime.h>


#pragma mark Constants

// Use the addresses as the key.
static char TEMPLATE_DICTIONARY_KEY;


#pragma mark - Class Definition

@implementation UITableView (Universal)


#pragma mark - Public Methods

- (id)templateCellWithCellNibNamed: (NSString *)nibName
{
	id templateDictionary = (id)objc_getAssociatedObject(self, &TEMPLATE_DICTIONARY_KEY);
	
	// Create the template dictionary on demand.
	if (templateDictionary == nil)
	{
		templateDictionary = [NSMutableDictionary dictionary];
		
		objc_setAssociatedObject(self, &TEMPLATE_DICTIONARY_KEY, templateDictionary, OBJC_ASSOCIATION_RETAIN);
	}
	
	// Get or create the template.
	UITableViewCell *cell = [templateDictionary objectForKey: nibName];
	
	// Create the cell on demand.
	if (cell == nil)
	{
		// Get or create the cell via the table view.
		cell = [UITableViewCell cellWithNibName: nibName];
		
		// Set the template flag.
		cell.isTemplate = YES;
		
		// Cache the template.
		[templateDictionary setObject: cell
			forKey: nibName];
	}
	
	return cell;
}

- (id)templateCellWithCellClass: (Class)cellClass
{
	id templateDictionary = (id)objc_getAssociatedObject(self, &TEMPLATE_DICTIONARY_KEY);
	
	// Create the template dictionary on demand.
	if (templateDictionary == nil)
	{
		templateDictionary = [NSMutableDictionary dictionary];
		
		objc_setAssociatedObject(self, &TEMPLATE_DICTIONARY_KEY, templateDictionary, OBJC_ASSOCIATION_RETAIN);
	}
	
	// Get or create the template.
	UITableViewCell *cell = [templateDictionary objectForKey: NSStringFromClass(cellClass)];
	
	// Create the cell on demand.
	if (cell == nil)
	{
		// Get or create the cell via the table view.
		cell = cellClass.new;
		
		// Set the template flag.
		cell.isTemplate = YES;
		
		// Cache the template.
		[templateDictionary setObject: cell
			forKey: NSStringFromClass(cellClass)];
	}
	
	return cell;
}

- (id)dequeueReusableCellWithNibName: (NSString *)nibName
{
	// Reuse cell if possible (or create one).
	UITableViewCell *cell = [self dequeueReusableCellWithIdentifier: nibName];
	
	// Create the cell on demand.
	if (cell == nil)
	{
		cell = [UITableViewCell cellWithNibName: nibName];
	}
	
	return cell;
}

- (id)dequeueReusableCellWithCellClass: (Class)cellClass
{
	NSString *className = NSStringFromClass(cellClass);
	
	// Reuse cell if possible (or create one).
	UITableViewCell *cell = [self dequeueReusableCellWithIdentifier: className];
	
	// Create the cell on demand.
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
	
	// Create the cell on demand.
	if (view == nil)
	{
		view = viewClass.new;
	}
	
	return view;
}


@end