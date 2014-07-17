#import "AFPageControl.h"


#pragma mark Class Definition

@implementation AFPageControl
{
    @private NSUInteger _currentPage;
	
    @private __strong UIControl *_pageContainer;
	@private __strong NSDictionary *_dotImages;
    @private __strong NSMutableArray *_pages;
}


#pragma mark - Properties

- (void)setCurrentPage: (NSUInteger)currentPage
{
    [self _updateCurrentPage: currentPage 
        raiseEvent: YES];
}

- (NSUInteger)numberOfPages
{
    return [_pages count];
}

- (void)setNumberOfPages: (NSUInteger)numberOfPages
{
    [self _updatePageCount: numberOfPages
		raiseEvent: YES];
}

- (NSString *)_keyForControlState: (UIControlState)controlState
{
	NSString *result = nil;

	switch (controlState)
	{
		case UIControlStateNormal:
			result = @"UIControlStateNormal";
		
		case UIControlStateHighlighted:
			result = @"UIControlStateHighlighted";
			
		default:
			result = nil;
	}
	
	return result;
}

- (void)setDotImage: (NSString *)dotImage
	forControlState: (UIControlState)controlState
{
	[_dotImages setValue: dotImage
		forKey: [self _keyForControlState: controlState]];
}

- (UIImage *)dotImageForState: (UIControlState)controlState
{
	return [_dotImages objectForKey: [self _keyForControlState: controlState]];
}


#pragma mark - Constructors

- (id)initWithCoder: (NSCoder *)coder
{
	if ((self = [super initWithCoder: coder]) == nil)
	{
		return nil;
	}

    // Initialize.
    [self _initializePageControl];

    return self;
}

- (id)initWithFrame: (CGRect)frame 
{
	if ((self = [super initWithFrame: frame]) == nil)
	{
		return nil;
	}

    // Initialize.
    [self _initializePageControl];

    return self;
}


#pragma mark - Public Methods

- (void)coerceCurrentPage: (NSUInteger)currentPage
{
    [self _updateCurrentPage: currentPage 
        raiseEvent: NO];
}

- (void)coercePageCount:(NSUInteger)numberOfPages
{
	[self _updatePageCount: numberOfPages 
		raiseEvent: NO];
}


#pragma mark - Internal Interface

- (void)_initializePageControl
{
    // Initialize instance variables.
    _pages = [[NSMutableArray alloc]
        init];
	_dotImages = [[NSDictionary alloc]
		init];
	
    self.opaque = NO;
    self.backgroundColor = [UIColor clearColor];
}

- (UIImage *)_dotNormalImage
{
	return [self dotImageForState: UIControlStateNormal];
}

- (UIImage *)_dotHighlightImage
{
	return [self dotImageForState: UIControlStateHighlighted];
}

- (void)_updatePageCount: (NSUInteger)numberOfPages
	raiseEvent: (BOOL)raiseEvent
{
	// skip if value is unchanged
    NSUInteger pageCount = [_pages count];
    if (numberOfPages == pageCount)
    {
        return;
    }
    
    // delete previous pages
    [_pages removeAllObjects];

    // unbind page container
    if (_pageContainer != nil)
    {
        // unwire events
        [_pageContainer removeTarget: self 
            action: @selector(_pageContainerTouched:withEvent:)
            forControlEvents: UIControlEventTouchDown];
                
        // delete page container
        [_pageContainer removeFromSuperview];
        _pageContainer = nil;
    }
    
    // skip if page count is zero
    pageCount = numberOfPages;
    if (pageCount == 0)
    {
        _currentPage = 0;
        return;
    }
    
    // create page container
    CGFloat pageMargin = roundf([self _dotNormalImage].size.width * 2.f / 3.f);
    CGSize pageSize = [self _dotNormalImage].size;
    CGRect frame = self.frame;
    CGFloat pageContainerWidth = (pageMargin * (pageCount + 1)) 
        + (pageSize.width * pageCount);
    _pageContainer = [[UIControl alloc]
        initWithFrame: CGRectMake(roundf((frame.size.width - pageContainerWidth) 
            / 2.f), 0.f, pageContainerWidth, frame.size.height)];
    
    // create new pages
    CGRect pageFrame = CGRectMake(pageMargin, roundf((frame.size.height 
        - pageSize.height) / 2.f), pageSize.width, pageSize.height);
    for (NSUInteger i = 0; i < pageCount; ++i)
    {
        // create new page
        UIImageView *page = [[UIImageView alloc]
            initWithFrame: pageFrame];
        page.contentMode = UIViewContentModeCenter;
        page.image = [self _dotNormalImage];
        page.highlightedImage = [self _dotHighlightImage];
        
        // bind page
        [_pageContainer addSubview: page];
        [_pages addObject: page];
        
        // update page frame
        pageFrame.origin.x = pageFrame.origin.x + pageSize.width + pageMargin;
    }
    
    // add page container to view
    [self addSubview: _pageContainer];
    
    // wire events
    [_pageContainer addTarget: self 
        action: @selector(_pageContainerTouched:withEvent:)
        forControlEvents: UIControlEventTouchDown];
    _pageContainer.opaque = NO;
    _pageContainer.backgroundColor = [UIColor clearColor];
    _pageContainer.userInteractionEnabled = YES;

    // update page
    _currentPage = -1;
    [self _updateCurrentPage: 0 
        raiseEvent: raiseEvent];
}
    
- (void)_updateCurrentPage: (NSUInteger)currentPage
    raiseEvent: (BOOL)raiseEvent
{
    // normalize value
    NSUInteger pageCount = [_pages count];
    currentPage = MAX(0, MIN(currentPage, pageCount - 1));

    // track if page actually changed
    BOOL pageChanged = _currentPage != currentPage;
    
    // remove highlight from previous page
    if (_currentPage < pageCount)
    {
        UIImageView *page = [_pages objectAtIndex: _currentPage];
        page.highlighted = NO;
    }
    
    // set highlight on new page
    _currentPage = currentPage;
    UIImageView *page = [_pages objectAtIndex: _currentPage];
    page.highlighted = YES;
    
    // raise value changed event (if required)
    if (pageChanged == YES
        && raiseEvent == YES)
    {
        [self sendActionsForControlEvents: UIControlEventValueChanged];
    }
}

- (void)_pageContainerTouched: (id)sender
    withEvent: (UIEvent *)event
{
    // resolve touch position
    CGPoint touchPoint = [[[event touchesForView: _pageContainer] 
        anyObject] 
            locationInView: _pageContainer];
            
    // determine page touched
    CGFloat pagePercent = touchPoint.x / _pageContainer.frame.size.width;
    NSUInteger pageIndex = pagePercent * [_pages count];
    
    // update current page
    self.currentPage = pageIndex;
}

@end