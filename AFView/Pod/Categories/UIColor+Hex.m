#import "UIColor+Hex.h"


#pragma mark Class Definition

@implementation UIColor (Hex)


#pragma mark - Public Methods

+ (UIColor *)colorWithHexString: (NSString *)hexString
{
	UIColor *result = nil;

	if ([hexString length] >= 6)
	{
		if ([hexString rangeOfString: @"0x"
			options: NSCaseInsensitiveSearch].location == 0)
		{
			hexString = [hexString substringFromIndex: 2];
		}
		else if ([hexString rangeOfString: @"#"].location == 0)
		{
			hexString = [hexString substringFromIndex: 1];
		}
		
		// Parse the hex color.
		result = [self _parseHexColor: hexString];
	}
	
	return result;
}

+ (UIColor *)colorWithHexValue: (int)hexValue
{
	return [[UIColor alloc]
		initWithRed: ((float)((hexValue & 0xFF0000) >> 16)) / 255.f 
		green: ((float)((hexValue & 0xFF00) >> 8)) / 255.f 
		blue: ((float)(hexValue & 0xFF)) / 255.f 
		alpha: 1.f];
}

+ (UIColor *)randomColor
{
	return [UIColor colorWithHexValue: arc4random() % INT_MAX];
}


#pragma mark - Private Methods

+ (UIColor *)_parseHexColor: (NSString *)hex
{
	UIColor *result = nil;

	unsigned int hexInt = 0;
	
	NSScanner *scanner = [NSScanner scannerWithString: hex];
	
	[scanner scanHexInt: &hexInt];
	
	if ([hex length] == 8)
	{
		result = [[UIColor alloc]
			initWithRed: ((float)((hexInt & 0xFF000000) >> 24)) / 255.f
			green: ((float)((hexInt & 0xFF0000) >> 16)) / 255.f
			blue: ((float)((hexInt & 0xFF00) >> 8)) / 255.f
			alpha: ((float)(hexInt & 0xFF)) / 255.f];
	}
	else if ([hex length] == 6)
	{
		return [self colorWithHexValue: hexInt];
	}
	
	return result;
}


@end
