#import "NSBundle+Universal.h"
#import "UIDevice+Hardware.h"


#pragma mark Constants

static NSString * const NibExtension = @"nib";


#pragma mark - Class Definition

@implementation NSBundle (Universal)


#pragma mark - Public Methods

- (NSString *)universalNibNameForNibName: (NSString *)nibName
{
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	// resolve nib name and path
	NSString *deviceNibName = [NSString stringWithFormat: @"%@_%@", nibName,
		[[UIDevice currentDevice] platformName]];
	
	// get device-specific nib path
	NSString *path = [self pathForResource: deviceNibName
		ofType: NibExtension];
	
	// if device-specific nib doesn't exist, fall back to shared nib
	if ([fileManager fileExistsAtPath: path] == NO)
	{
		// fall back to shared nib
		deviceNibName = nibName;
		
		// get shared nib path
		path = [self pathForResource: deviceNibName 
			ofType: NibExtension];
		
		// finally, if shared nib doesn't exist, fall back to iPhone nib
		if ([fileManager fileExistsAtPath: path] == NO)
		{		
			// fall back to iPhone nib
			deviceNibName = [NSString stringWithFormat: @"%@_iPhone", nibName];
			
			// get iPhone nib path
			path = [self pathForResource: deviceNibName 
				ofType: @"nib"];
			
			if ([fileManager fileExistsAtPath: path] == NO)
			{
				// Asset really doesn't exist anywhere.
				@throw [NSException exceptionWithName: @"Nib not found"
					reason: [NSString stringWithFormat: @"No nib was found with the name: %@", nibName]
					userInfo: nil];
			}
		}
	}
	
	// return existent nib name
	return deviceNibName;
}


@end