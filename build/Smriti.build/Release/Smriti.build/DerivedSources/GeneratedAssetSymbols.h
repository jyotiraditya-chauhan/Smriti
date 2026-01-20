#import <Foundation/Foundation.h>

#if __has_attribute(swift_private)
#define AC_SWIFT_PRIVATE __attribute__((swift_private))
#else
#define AC_SWIFT_PRIVATE
#endif

/// The "background_image" asset catalog image resource.
static NSString * const ACImageNameBackgroundImage AC_SWIFT_PRIVATE = @"background_image";

/// The "envelope" asset catalog image resource.
static NSString * const ACImageNameEnvelope AC_SWIFT_PRIVATE = @"envelope";

/// The "logo" asset catalog image resource.
static NSString * const ACImageNameLogo AC_SWIFT_PRIVATE = @"logo";

#undef AC_SWIFT_PRIVATE
