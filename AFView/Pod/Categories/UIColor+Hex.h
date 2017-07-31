

#pragma mark Class Interface

@interface UIColor (Hex)


#pragma mark - Instance Methods

+ (UIColor *)colorWithHexString: (NSString *)hexString;

+ (UIColor *)colorWithHexValue: (int)hexValue;

+ (UIColor *)randomColor;


@end
