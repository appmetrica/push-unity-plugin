
#import "AMPUAppMetricaConfigStorage.h"
#import "AMPUUtils.h"

@implementation AMPUAppMetricaConfigStorage

NSString *const kAMPUUserDefaultsAppMetricaConfigKey = @"io.appmetrica.push.unity.AppMetricaConfig";

+ (void)saveConfig:(char *)config
{
    NSString *str = [NSString stringWithUTF8String:config];
    [[NSUserDefaults standardUserDefaults] setObject:str forKey:kAMPUUserDefaultsAppMetricaConfigKey];
}

+ (char *)loadConfig
{
    NSString *str = [[NSUserDefaults standardUserDefaults] stringForKey:kAMPUUserDefaultsAppMetricaConfigKey];
    return [AMPUUtils cStringFromString:str];
}

@end
