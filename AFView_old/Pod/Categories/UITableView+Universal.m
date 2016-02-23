#import "UITableView+Universal.h"
#import "UITableViewCell+Universal.h"
#import <objc/runtime.h>


#pragma mark Constants

// Use the addresses as the key.
static char TEMPLATE_DICTIONARY_KEY;


#pragma mark - Class Definition

@implementation UITableView (Universal)


#pragma mark - Public Methods

- (id)templateCellWithCellNibName: (NSString *)nibName
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
	
	NSString *cellClassName = NSStringFromClass(cellClass);
	
	// Create the template dictionary on demand.
	if (templateDictionary == nil)
	{
		templateDictionary = [NSMutableDictionary dictionary];
		
		objc_setAssociatedObject(self, &TEMPLATE_DICTIONARY_KEY, templateDictionary, OBJC_ASSOCIATION_RETAIN);
	}
	
	// Get or create the template.
	UITableViewCell *cell = [templateDictionary objectForKey: cellClassName];
	
	// Create the cell on demand.
	if (cell == nil)
	{
		// Get or create the cell via the table view.
		cell = [[cellClass alloc]
			initWithStyle: UITableViewCellStyleDefault
			reuseIdentifier: cellClassName];
		
		// Set the template flag.
		cell.isTemplate = YES;
		
		// Cache the template.
		[templateDictionary setObject: cell
			forKey: cellClassName];
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
	NSString *cellClassName = NSStringFromClass(cellClass);
	
	// Reuse cell if possible (or create one).
	UITableViewCell *cell = [self dequeueReusableCellWithIdentifier: cellClassName];
	
	// Create the cell on demand.
	if (cell == nil)
	{
		cell = [[cellClass alloc]
			initWithStyle: UITableViewCellStyleDefault
			reuseIdentifier: cellClassName];
	}
	
	return cell;
}

- (id)dequeueReusableHeaderFooterViewWithViewClass: (Class)viewClass
{
	NSString *cellClassName = NSStringFromClass(viewClass);
	
	// Reuse view if possible (or create one).
	UIView *view = [self dequeueReusableHeaderFooterViewWithIdentifier: cellClassName];
	
	// Create the cell on demand.
	if (view == nil)
	{
		view = viewClass.new;
	}
	
	return view;
}


@end