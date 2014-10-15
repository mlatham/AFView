#import "UITableViewCell+Universal.h"
#import "NSBundle+Universal.h"
#import <objc/runtime.h>


#pragma mark Constants

// Use the addresses as the key.
static char IS_TEMPLATE_KEY;


#pragma mark - Class Definition

@implementation UITableViewCell (Universal)


#pragma mark - Properties

- (void)setIsTemplate: (BOOL)isTemplate
{
	NSNumber *isTemplateAssociated = [NSNumber numberWithBool: isTemplate];
		
	objc_setAssociatedObject(self, &IS_TEMPLATE_KEY, isTemplateAssociated, OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)isTemplate
{
	id isTemplate = (id)objc_getAssociatedObject(self, &IS_TEMPLATE_KEY);
	
	// If unset - this is not a template.
	if (isTemplate == nil)
	{
		return NO;
	}
	else
	{
		return [isTemplate boolValue];
	}
}


#pragma mark - Public Methods

+ (instancetype)cellWithNibName: (NSString *)nibName
{
	return [self cellWithNibName: nibName
		bundle: nil];
}

+ (instancetype)cellWithNibName: (NSString *)nibName
	bundle: (NSBundle *)nibBundleOrNil
{
	NSBundle *bundle = nibBundleOrNil == nil 
		? [NSBundle mainBundle] 
		: nibBundleOrNil;

	NSArray *nibContents = [bundle
		loadNibNamed: nibName
		owner: self 
		options: nil];
	
	// Return first object in nib.
	id nibRoot = [nibContents objectAtIndex: 0];
	
	// Validate nib contained a cell.
	NSAssert([nibRoot isKindOfClass: UITableViewCell.class], @"Expected a UITableViewCell at the nib root");
	
	return nibRoot;
}

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