#import "UIApplication+Helpers.h"
#import <QuartzCore/QuartzCore.h>


#pragma mark Class Variables

static __strong UIWindow *_rootKeyWindow;


#pragma mark - Class Definition

@implementation UIApplication (Helpers)


#pragma mark - Public Methods

+ (UIWindow *)rootKeyWindow
{
	return _rootKeyWindow;
}

+ (void)setRootKeyWindow: (UIWindow *)rootKeyWindow
{
	_rootKeyWindow = rootKeyWindow;
}

+ (UIImage *)takeScreenshot
{
	UIApplication *application = [UIApplication sharedApplication];

	if ([[UIScreen mainScreen] respondsToSelector: @selector(scale)])
	{
		UIGraphicsBeginImageContextWithOptions(application.keyWindow.bounds.size, NO, [UIScreen mainScreen].scale);
	}
	else
	{
		UIGraphicsBeginImageContext(application.keyWindow.bounds.size);
	}
	
	[application.keyWindow.layer renderInContext: UIGraphicsGetCurrentContext()];
	
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	
	UIGraphicsEndImageContext();
	
	return image;
}


@end
