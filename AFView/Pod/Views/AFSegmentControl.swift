import Foundation

public class AFSegmentControl : UIControl
{
	// MARK: - Properties
	
	private var _backgroundHidden: Bool = false
	private var _backgroundImageView: UIImageView?
	private var _segmentContainer: UIView?
	
	private var _selectedSegmentIndices: [Int]
	private var _selectedSegmentItems: [AnyObject]
	
	private var _segmentItems: [AnyObject]?
	private var _segmentViews: [UIView]
	
	public var backgroundHidden: Bool
	{
		set
		{
			_backgroundHidden = newValue
			
			_updateBackgroundHidden()
		}
		get
		{
			return _backgroundHidden
		}
	}
	
	public var firstSelectedSegmentIndex: Int
	{
		get
		{
			if _selectedSegmentIndices.count > 0
			{
				return _selectedSegmentIndices[0]
			}
			else
			{
				return NSNotFound
			}
		}
	}
	
	public var firstSelectedSegmentItem: AnyObject?
	{
		get
		{
			let firstSelectedSegmentIndex: Int = self.firstSelectedSegmentIndex
			
			return firstSelectedSegmentIndex != NSNotFound
				? _selectedSegmentItems[firstSelectedSegmentIndex]
				: nil
		}
	}
	
	public var segmentItems: [AnyObject]
	{
		get
		{
			var segmentItems: [AnyObject] = []
			
			if let _segmentItems = _segmentItems
			{
				for selectedSegmentIndex in _selectedSegmentIndices
				{
					segmentItems.append(_segmentItems[selectedSegmentIndex])
				}
			}
			
			return segmentItems
		}
		set
		{
			// Set segment titles.
			_segmentItems = newValue
			
			// Reload the segment buttons.
			self.reloadSegmentViews()
		}
	}
	
	
	// MARK: - Constructors
	
	public override init(frame: CGRect)
	{
		super.init(frame: frame)
		
		_initialize()
	}
	
    public required init?(coder aDecoder: NSCoder)
	{
		super.init(coder: aDecoder)
		
		_initialize()
	}
	
	
	// MARK: - Public Methods
	
	public func deselectAll()
	{
		// Clear all selected indices.
		_selectedSegmentIndices.removeAll()
		
		// Raise that the selection has changed.
		self.sendActionsForControlEvents(.ValueChanged)
		
		// Update the segment selections.
		_updateSegmentSelections()
	}
	
	public func deselectItemAtIndex(index: Int)
	{
		var indices = _selectedSegmentIndices
	
		for i in indices.count...0
		{
			let number = indices[i]
		
			// Remove the number from the list of selections.
			if number == index
			{
				_selectedSegmentIndices.removeAtIndex(i)
			}
		}
		
		// Update the segment selections.
		_updateSegmentSelections()
	}
	
	public func selectItemAtIndex(index: Int)
	{
		var itemSelected: Bool = false
		
		if !self.multiselectEnabled
		{
			if _selectedSegmentIndices.count == 1
				&& self.firstSelectedSegmentIndex == index
			{
				// Update the segment selections.
				_updateSegmentSelections()
				
				// Early out - index is already selected.
				return
			}
			
			// Otherwise, remove all indices.
			_selectedSegmentIndices.removeAll()
		}
		
		for number in _selectedSegmentIndices
		{
			if number == index
			{
				itemSelected = true
			}
		}
		
		// Add the item if it is not selected.
		if !itemSelected
		{
			_selectedSegmentIndices.append(index)
			
			// Raise that the selection has changed.
			self.sendActionsForControlEvents(.ValueChanged)
		}
		
		// Update the segment selections.
		_updateSegmentSelections()
	}
	
	public func selectItemsAtIndices(indices: [Int])
	{
		// Clear all selected indices.
		_selectedSegmentIndices.removeAll()
		
		// Select the indices.
		for number in indices
		{
			_selectedSegmentIndices.append(number)
		}
		
		// Raise that the selection has changed.
		self.sendActionsForControlEvents(.ValueChanged)
		
		// Update the segment selections.
		_updateSegmentSelections()
	}
}


//- (void)reloadSegmentViews
//{
//	CGFloat totalWidth = self.width;
//	CGFloat buttonWidth = floorf(totalWidth / [_segmentItems count]);
//	CGFloat buttonX = 0.f;
//
//	// Clear any existing buttons.
//	[_segmentViews removeAllObjects];
//	[_segmentContainer removeAllSubviews];
//
//	// Add all the segment buttons.
//	for (int i = 0; i < [_segmentItems count]; i++)
//	{
//		// Get the segment item.
//		id segment = [_segmentItems objectAtIndex: i];
//		
//		// Last segment should occupy remaining space.
//		if (i == [_segmentItems count] - 1)
//		{
//			buttonWidth = totalWidth - buttonX;
//		}
//	
//		// Create a button for each segment.
//		AFSegmentButton *button = [[AFSegmentButton alloc]
//			initWithFrame: CGRectMake(
//				buttonX,
//				0.f,
//				buttonWidth,
//				self.height - 1.f)];
//		button.autoresizingMask = UIViewAutoresizingFlexibleWidth
//			| UIViewAutoresizingFlexibleLeftMargin
//			| UIViewAutoresizingFlexibleRightMargin;
//		button.titleLabel.font = [UIFont boldSystemFontOfSize: 14.f];
//		[button addTarget: self
//			action: @selector(_segmentSelected:)
//			forControlEvents: UIControlEventTouchDown];
//		[button setTitle: [segment description]
//			forState: UIControlStateNormal];
//		// TODO: Title color.
//		[_segmentContainer addSubview: button];
//		[_segmentViews addObject: button];
//		
//		// Increment button X.
//		buttonX += buttonWidth;
//	}
//	
//	// Update the background hiddenness.
//	[self _updateBackgroundHidden];
//	
//	// Update segment selections.
//	[self _updateSegmentSelections];
//}
//
//
//#pragma mark - Private Methods
//
//- (void)_initializeSegmentControl
//{
//    // Initialize instance variables.
//	_selectedSegmentIndices = [[NSMutableArray alloc]
//		init];
//	_segmentViews = [[NSMutableArray alloc]
//        init];
//	_segmentItems = [[NSMutableArray alloc]
//		init];
//	_backgroundHidden = NO;
//    self.backgroundColor = [UIColor clearColor];
//    self.opaque = NO;
//        
//    // Initialize container view.
//	_segmentContainer = [[UIView alloc]
//		initWithFrame: CGRectMake(
//			0.f,
//			0.f,
//			self.frame.size.width,
//			self.frame.size.height)];
//	_segmentContainer.autoresizingMask = UIViewAutoresizingFlexibleHeight
//		| UIViewAutoresizingFlexibleWidth;
//	[self addSubview: _segmentContainer];
//	
//	// Add the background image view.
//	_backgroundImageView = [[UIImageView alloc]
//		initWithFrame: CGRectMake(
//			0.f,
//			0.f,
//			self.frame.size.width,
//			self.frame.size.height)];
//	_backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight
//		| UIViewAutoresizingFlexibleWidth;
//	[self addSubview: _backgroundImageView];
//	[self sendSubviewToBack: _backgroundImageView];
//	[self _updateBackgroundImage];
//}
//
//- (void)_segmentSelected: (UIButton *)sender
//{
//	// Get the index of this segment.
//	NSUInteger selectedSegmentIndex = [_segmentViews indexOfObject: sender];
//	
//	BOOL selected = NO;
//
//	// Determine if this segment is selected.
//	for (NSNumber *index in _selectedSegmentIndices)
//	{
//		if (index.integerValue == selectedSegmentIndex)
//		{
//			selected = YES;
//		}
//	}
//	
//	// If multiselect is enabled, toggle this segment.
//	if (self.multiselectEnabled == YES)
//	{
//		if (selected == YES)
//		{
//			// Deselect the segment.
//			[self deselectItemAtIndex: selectedSegmentIndex];
//		}
//		else
//		{
//			// Select the segment.
//			[self selectItemAtIndex: selectedSegmentIndex];
//		}
//	}
//	
//	// Otherwise, select this segment only if it's not selected.
//	else
//	{
//		if (selected == NO)
//		{
//			// Clear any existing selection.
//			[_selectedSegmentIndices removeAllObjects];
//			
//			// Select the segment.
//			[self selectItemAtIndex: selectedSegmentIndex];
//		}
//	}
//	
//	// Sort the buttons from left to right.
//	for (UIButton *button in _segmentViews)
//	{
//		[_segmentContainer bringSubviewToFront: button];
//	}
//	
//	// TODO: Fix keylines on these views.
//	// Bring any selected buttons to the front.
//	for (int i = 0; i < [_segmentViews count]; i++)
//	{
//		UIButton *button = [_segmentViews objectAtIndex: i];
//	
//		for (NSNumber *selectedSegmentIndex in _selectedSegmentIndices)
//		{
//			if (selectedSegmentIndex.integerValue == i)
//			{
//				[_segmentContainer bringSubviewToFront: button];
//			}
//		}
//	}
//}
//
//- (void)_updateBackgroundImage
//{
//	// TODO: Create a reasonable default background here.
//}
//
//- (void)_updateSegmentSelections
//{
//	BOOL previousSegmentSelected = NO;
//
//	for (int i = 0; i < [_segmentViews count]; i++)
//	{
//		AFSegmentButton *button = [_segmentViews objectAtIndex: i];
//		BOOL selected = NO;
//		
//		for (NSNumber *selectedSegmentIndex in _selectedSegmentIndices)
//		{
//			if (selectedSegmentIndex.integerValue == i)
//			{
//				selected = YES;
//			}
//		}
//		
//		// Set the selected state of this button.
//		[self _setSelected: selected
//			previousButtonSelected: previousSegmentSelected
//			button: button];
//			
//		// Hide the leftmost and rightmost keylines.
//		if (i == 0)
//		{
//			button.keyline.hidden = YES;
//		}
//		
//		// Track whether or not the previous segment was selected.
//		previousSegmentSelected = selected;
//	}
//}
//
//- (void)_setSelected: (BOOL)selected
//	previousButtonSelected: (BOOL)previousButtonSelected
//	button: (AFSegmentButton *)button
//{
//	// Determine title color.
//	UIColor *titleColor = nil;
//	UIFont *titleFont = nil;
//	
//	if (selected == YES)
//	{
//		// TODO: Determine the segment highlighted color.
//		titleColor = nil;
//		titleFont = [UIFont boldSystemFontOfSize: 14.f];
//	}
//	else
//	{
//		// TODO: Determine the segment normal color.
//		titleColor = nil;
//		titleFont = [UIFont systemFontOfSize: 14.f];
//	}
//	
//	// Set the title color.
//	[button setTitleColor: titleColor
//		forState: UIControlStateNormal];
//	button.titleLabel.font = titleFont;
//	
//	// Adjust the button height and keylines based on selection.
//	if (selected == YES)
//	{
//		button.height = self.height;
//	}
//	else
//	{
//		button.height = self.height - 1.f;
//	}
//}
//
//- (void)_updateBackgroundHidden
//{
//	_backgroundImageView.hidden = _backgroundHidden;
//	
//	for (AFSegmentButton *button in _segmentViews)
//	{
//		button.backgroundHidden = _backgroundHidden;
//	}
//}
