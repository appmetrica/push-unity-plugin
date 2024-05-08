
#import "AMPUUtils.h"

@implementation AMPUUtils

+ (NSString *)stringForTokenData:(NSData *)deviceToken
{
    if (deviceToken.length == 0) {
        return nil;
    }

    const char *bytes = [deviceToken bytes];
    NSMutableString *token = [NSMutableString string];
    for (NSUInteger i = 0; i < deviceToken.length; ++i) {
        [token appendFormat:@"%02.2hhx", bytes[i]];
    }
    return [token copy];
}

+ (char *)cStringFromString:(NSString *)string
{
    if (string == nil) {
        return nil;
    }
    
    const char *cString = [string UTF8String];
    char *result = (char *)malloc(strlen(cString) + 1);
    strcpy(result, cString);
    return result;
}

@end
