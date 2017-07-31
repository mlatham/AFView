#import "AFAppDelegate.h"
#import "AFView-Includes.h"
#import "AFDemoController.h"


#pragma mark Class Implementation

@implementation AFAppDelegate


#pragma mark - Public Methods

- (BOOL)application: (UIApplication *)application
	didFinishLaunchingWithOptions: (NSDictionary *)launchOptions
{
	// Create the main window.
	UIScreen *mainScreen = [UIScreen mainScreen];
	UIWindow *mainWindow = [[UIWindow alloc]
		initWithFrame: mainScreen.bounds];
	mainWindow.frame = [[UIScreen mainScreen] bounds];
	mainWindow.backgroundColor = [UIColor blackColor];
	mainWindow.rootViewController = [[AFDemoController alloc] init];
	
	// Track this window as the root key window of the application.
	[UIApplication setRootKeyWindow: mainWindow];
	
	// Show the main window.
	[mainWindow makeKeyAndVisible];

    return YES;
}
							
- (void)applicationWillResignActive: (UIApplication *)application
{
}

- (void)applicationDidEnterBackground: (UIApplication *)application
{
}

- (void)applicationWillEnterForeground: (UIApplication *)application
{
}

- (void)applicationDidBecomeActive: (UIApplication *)application
{
}

- (void)applicationWillTerminate: (UIApplication *)application
{
}

@end // @implementation AFAppDelegate
