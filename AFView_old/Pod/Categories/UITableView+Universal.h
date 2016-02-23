#import "UIKit/UIKit.h"


#pragma mark Class Interface

@interface UITableView (Universal)


#pragma mark - Instance Methods

- (id)templateCellWithCellNibName: (NSString *)nibName;

- (id)templateCellWithCellClass: (Class)cellClass;

- (id)dequeueReusableCellWithNibName: (NSString *)nibName;

- (id)dequeueReusableCellWithCellClass: (Class)cellClass;

- (id)dequeueReusableHeaderFooterViewWithViewClass: (Class)viewClass;


@end