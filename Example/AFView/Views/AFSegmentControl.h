

#pragma mark Class Interface

@interface AFSegmentControl : UIControl


#pragma mark - Properties

@property (nonatomic, assign, readonly) NSUInteger numberOfSegments;

@property (nonatomic, assign, readonly) NSUInteger firstSelectedSegmentIndex;
@property (nonatomic, strong, readonly) id firstSelectedSegmentItem;

@property (nonatomic, strong, readonly) NSArray *selectedSegmentIndices;
@property (nonatomic, strong, readonly) NSArray *selectedSegmentItems;
@property (nonatomic, strong, readonly) NSArray *segmentViews;

@property (nonatomic, copy) NSArray *segmentItems;

@property (nonatomic, assign) BOOL multiselectEnabled;
@property (nonatomic, assign) BOOL backgroundHidden;


#pragma mark - Public Methods

- (void)deselectAll;
- (void)deselectItemAtIndex: (NSInteger)index;
- (void)selectItemAtIndex: (NSInteger)index;
- (void)selectItemsAtIndices: (NSArray *)indices;

- (void)reloadSegmentViews;


@end