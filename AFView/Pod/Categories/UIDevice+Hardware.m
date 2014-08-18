#import "UIDevice+Hardware.h"
#include <sys/sysctl.h>


#pragma mark Class Variables

static NSString *_OSVersion = nil;


#pragma mark Class Definition

@implementation UIDevice (Hardware)


#pragma mark - Properties

- (AFDeviceFamily)AFDeviceFamily
{
	NSString *platform = [self _getSysInfoByName: "hw.machine"];
	
    if ([platform hasPrefix: @"iPhone"])			return AFDeviceFamilyiPhone;
    if ([platform hasPrefix: @"iPod"])				return AFDeviceFamilyiPod;
    if ([platform hasPrefix: @"iPad"])				return AFDeviceFamilyiPad;
    if ([platform hasPrefix: @"AppleTV"])			return AFDeviceFamilyAppleTV;
    
    return AFDeviceFamilyUnknown;
}

- (AFDevice)AFDevice
{
	NSString *platform = [self _getSysInfoByName: "hw.machine"];

    // The ever mysterious iFPGA
    if ([platform isEqualToString: @"iFPGA"])        return AFDeviceIFPGA;

    // iPhone
    if ([platform isEqualToString: @"iPhone1,1"])    return AFDevice1GiPhone;
    if ([platform isEqualToString: @"iPhone1,2"])    return AFDevice3GiPhone;
    if ([platform hasPrefix: @"iPhone2"])            return AFDevice3GSiPhone;
    if ([platform hasPrefix: @"iPhone3"])            return AFDevice4iPhone;
    if ([platform hasPrefix: @"iPhone4"])            return AFDevice4SiPhone;
    if ([platform hasPrefix: @"iPhone5"])            return AFDevice5iPhone;
    
    // iPod
    if ([platform hasPrefix: @"iPod1"])              return AFDevice1GiPod;
    if ([platform hasPrefix: @"iPod2"])              return AFDevice2GiPod;
    if ([platform hasPrefix: @"iPod3"])              return AFDevice3GiPod;
    if ([platform hasPrefix: @"iPod4"])              return AFDevice4GiPod;

    // iPad
    if ([platform hasPrefix: @"iPad1"])              return AFDevice1GiPad;
    if ([platform hasPrefix: @"iPad2"])              return AFDevice2GiPad;
    if ([platform hasPrefix: @"iPad3"])              return AFDevice3GiPad;
    if ([platform hasPrefix: @"iPad4"])              return AFDevice4GiPad;
    
    // Apple TV
    if ([platform hasPrefix: @"AppleTV2"])           return AFDeviceAppleTV2;
    if ([platform hasPrefix: @"AppleTV3"])           return AFDeviceAppleTV3;

    if ([platform hasPrefix: @"iPhone"])             return AFDeviceUnknowniPhone;
    if ([platform hasPrefix: @"iPod"])               return AFDeviceUnknowniPod;
    if ([platform hasPrefix: @"iPad"])               return AFDeviceUnknowniPad;
    if ([platform hasPrefix: @"AppleTV"])            return AFDeviceUnknownAppleTV;
    
    // Simulator
    if ([platform hasSuffix: @"86"]
		|| [platform isEqual: @"x86_64"])
    {
        BOOL smallerScreen = [[UIScreen mainScreen] bounds].size.width < 768;
		
        return smallerScreen
			? AFDeviceSimulatoriPhone
			: AFDeviceSimulatoriPad;
    }

    return AFDeviceUnknown;
}

- (AFDeviceOrientation)AFDeviceOrientation
{
	// use interface orientation (if possible)
    UIWindow *mainWindow = [[UIApplication sharedApplication]
        keyWindow];
    if (mainWindow != nil
        && mainWindow.rootViewController != nil)
    {
        UIInterfaceOrientation interfaceOrientation = 
            [mainWindow rootViewController].interfaceOrientation;
        return interfaceOrientation == 
            UIInterfaceOrientationIsPortrait(interfaceOrientation)
                ? AFDeviceOrientationPortrait : AFDeviceOrientationLandscape;
    }

    // fallback to device value (if known)
	UIDeviceOrientation orientation = [[UIDevice currentDevice] 
        orientation];	
    if (orientation == UIDeviceOrientationUnknown)
    {
        return AFDeviceOrientationPortrait;
    }
        
	if (UIDeviceOrientationIsLandscape(orientation))
    {
        return AFDeviceOrientationLandscape;
    }
    else 
    {
        return AFDeviceOrientationPortrait;
    }

}

- (CGFloat)contentWidth
{
	UIScreen *mainScreen = [UIScreen mainScreen];
	return mainScreen.applicationFrame.size.width;
}

- (CGFloat)contentHeight
{
	UIScreen *mainScreen = [UIScreen mainScreen];
	return mainScreen.applicationFrame.size.height;
}

- (CGFloat)keyboardHeight
{
	return self.orientation == AFDeviceOrientationLandscape
		? [self _keyboardHeightLandscape]
		: [self _keyboardHeightPortrait];
}

- (NSString *)platformName
{
	switch (self.AFDeviceFamily)
	{
		case AFDeviceFamilyiPod:
		case AFDeviceFamilyiPhone:
		{
			return @"iPhone";
		}
		case AFDeviceFamilyiPad:
		{
			return @"iPad";
		}
		case AFDeviceFamilyAppleTV:
		{
			return @"iAppleTV";
		}
		case AFDeviceFamilyUnknown:
		{
			return @"";
		}
	}
}


#pragma mark - Public Methods

- (CGFloat)keyboardHeightForOrientation: (AFDeviceOrientation)orientation
{
	return orientation == AFDeviceOrientationLandscape
		? [self _keyboardHeightLandscape]
		: [self _keyboardHeightPortrait];
}

- (CGFloat)contentHeightForOrientation: (AFDeviceOrientation)orientation
{
	UIScreen *mainScreen = [UIScreen mainScreen];
	CGRect frame = mainScreen.bounds;
	CGFloat contentHeight = orientation == AFDeviceOrientationLandscape
		? frame.size.width
		: frame.size.height;
	
	return contentHeight;
}

- (CGFloat)contentWidthForOrientation: (AFDeviceOrientation)orientation
{
	UIScreen *mainScreen = [UIScreen mainScreen];
	CGRect frame = mainScreen.bounds;
	CGFloat contentWidth = orientation == AFDeviceOrientationLandscape
		? frame.size.height
		: frame.size.width;
	
	return contentWidth;
}


#pragma mark - Private Methods

- (CGFloat)_keyboardHeightLandscape
{
	return self.AFDeviceFamily == AFDeviceFamilyiPad
		? 352.f
		: 162.f;
}

- (CGFloat)_keyboardHeightPortrait
{
	return self.AFDeviceFamily == AFDeviceFamilyiPad
		? 264.f
		: 216.f;
}

- (NSString *)_getSysInfoByName: (char *)typeSpecifier
{
    size_t size;
	
    sysctlbyname(typeSpecifier, NULL, &size, NULL, 0);
    
    char *answer = malloc(size);
    sysctlbyname(typeSpecifier, answer, &size, NULL, 0);
    
    NSString *results = [NSString stringWithCString:answer encoding: NSUTF8StringEncoding];

    free(answer);
    return results;
}


@end // @implementation UIDevice (Hardware)