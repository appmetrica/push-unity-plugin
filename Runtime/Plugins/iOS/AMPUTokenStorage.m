
#import "AMPUTokenStorage.h"

@implementation AMPUTokenStorage

NSString *const kAMPUUserDefaultsTokenKey = @"io.appmetrica.push.unity.PushToken";

+ (void)saveToken:(NSData *)token
{
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:kAMPUUserDefaultsTokenKey];
}

+ (NSData *)getToken
{
    return [[NSUserDefaults standardUserDefaults] dataForKey:kAMPUUserDefaultsTokenKey];
}

@end
