

#pragma mark Enumerations

typedef enum
{
    AFDeviceUnknown,
    
    AFDeviceSimulator,
    AFDeviceSimulatoriPhone,
    AFDeviceSimulatoriPad,
    AFDeviceSimulatorAppleTV,
    
    AFDevice1GiPhone,
    AFDevice3GiPhone,
    AFDevice3GSiPhone,
    AFDevice4iPhone,
    AFDevice4SiPhone,
    AFDevice5iPhone,
    
    AFDevice1GiPod,
    AFDevice2GiPod,
    AFDevice3GiPod,
    AFDevice4GiPod,
    
    AFDevice1GiPad,
    AFDevice2GiPad,
    AFDevice3GiPad,
    AFDevice4GiPad,
    
    AFDeviceAppleTV2,
    AFDeviceAppleTV3,
    AFDeviceAppleTV4,
    
    AFDeviceUnknowniPhone,
    AFDeviceUnknowniPod,
    AFDeviceUnknowniPad,
    AFDeviceUnknownAppleTV,
    AFDeviceIFPGA,

} AFDevice;

typedef enum
{
    AFDeviceFamilyiPhone,
    AFDeviceFamilyiPod,
    AFDeviceFamilyiPad,
    AFDeviceFamilyAppleTV,
    AFDeviceFamilyUnknown,
    
} AFDeviceFamily;

typedef enum 
{
	AFDeviceOrientationPortrait,
	AFDeviceOrientationLandscape

} AFDeviceOrientation;


#pragma mark Class Interface

@interface UIDevice (Hardware)


#pragma mark - Properties

@property (nonatomic, readonly) AFDevice AFDevice;
@property (nonatomic, readonly) AFDeviceFamily AFDeviceFamily;
@property (nonatomic, readonly) AFDeviceOrientation AFDeviceOrientation;

@property (nonatomic, readonly) CGFloat contentWidth;
@property (nonatomic, readonly) CGFloat contentHeight;
@property (nonatomic, readonly) CGFloat keyboardHeight;

@property (nonatomic, readonly) NSString *platformName;


#pragma mark - Methods

- (CGFloat)keyboardHeightForOrientation: (AFDeviceOrientation)orientation;
- (CGFloat)contentHeightForOrientation: (AFDeviceOrientation)orientation;
- (CGFloat)contentWidthForOrientation: (AFDeviceOrientation)orientation;


@end // @interface UIDevice (Hardware)