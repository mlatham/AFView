#import "UIKit/UIKit.h"


#pragma mark Class Interface

@interface UITableView (Universal)


#pragma mark - Instance Methods

- (id)templateCellWithCellClass: (Class)cellClass;

- (id)dequeueReusableCellWithCellClass: (Class)cellClass;

- (id)dequeueReusableHeaderFooterViewWithViewClass: (Class)viewClass;


@end