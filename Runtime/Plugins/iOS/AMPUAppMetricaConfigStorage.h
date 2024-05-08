
#import <Foundation/Foundation.h>

@interface AMPUAppMetricaConfigStorage : NSObject

+ (void)saveConfig:(char *)token;
+ (char *)loadConfig;

@end
