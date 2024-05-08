
#import <AppMetricaCore/AppMetricaCore.h>
#import <AppMetricaPush/AppMetricaPush.h>

#import "AMPUAppMetricaPushProxy.h"
#import "AMPUAppMetricaConfigStorage.h"
#import "AMPUTokenStorage.h"
#import "AMPUUtils.h"

void ampu_activate()
{
    if (AMAAppMetrica.isActivated) {
        NSData *token = [AMPUTokenStorage getToken];
        if (token != nil) {
#ifdef DEBUG
            AMPAppMetricaPushEnvironment pushEnvironment = AMPAppMetricaPushEnvironmentDevelopment;
#else
            AMPAppMetricaPushEnvironment pushEnvironment = AMPAppMetricaPushEnvironmentProduction;
#endif
            [AMPAppMetricaPush setDeviceTokenFromData:token pushEnvironment:pushEnvironment];
        }
    }
}

char *ampu_getToken()
{
    NSString *token = [AMPUUtils stringForTokenData:[AMPUTokenStorage getToken]];
    return [AMPUUtils cStringFromString:token];
}

void ampu_saveAppMetricaConfig(char *appMetricaConfig)
{
    [AMPUAppMetricaConfigStorage saveConfig:appMetricaConfig];
}
