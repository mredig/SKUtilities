#define kPadToPhoneScale_SKUTIL ((CGFloat) 0.41666)
#define kPhoneFromPadScale_SKUTIL ((CGFloat) 0.41666)
#define kPhoneToPadScale_SKUTIL ((CGFloat) 2.40003840061441) //likely very low usage as it would be upscaling
#define kPadFromPhoneScale_SKUTIL ((CGFloat) 2.40003840061441)

#define kDegToRadConvFactor_SKUTIL 0.017453292519943295 // pi/180 //SKUTIL is appended to assure uniqueness
#define kRadToDegConvFactor_SKUTIL 57.29577951308232 // 180/pi

#define VISIBLE 0 //for node.hidden properties, this is more intuitive than YES/NO
#define HIDDEN 1 //for node.hidden properties, this is more intuitive than YES/NO

#if TARGET_OS_IPHONE
#define SKUImage UIImage
#define SKUFont UIFont
#else
#define SKUImage NSImage
#define SKUFont NSFont
#endif