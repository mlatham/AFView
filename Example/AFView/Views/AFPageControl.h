

#pragma mark Class Interface

@interface AFPageControl : UIControl


#pragma mark - Properties

// NOTE: Adjusting the segment count creates segments as needed.
@property (nonatomic, assign) NSUInteger currentPage;
@property (nonatomic, assign) NSUInteger numberOfPages;


#pragma mark - Methods

- (void)coerceCurrentPage: (NSUInteger)currentPage;

- (void)coercePageCount: (NSUInteger)numberOfPages;

- (void)setDotImage: (NSString *)dotImage
	forControlState: (UIControlState)controlState;

- (UIImage *)dotImageForState: (UIControlState)controlState;


@end