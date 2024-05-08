
#import <AppMetricaCore/AppMetricaCore.h>
#import <AppMetricaPush/AppMetricaPush.h>

#import "AMAUAppMetricaPushHelper.h"

#import "UnityAppController.h"
#import "AMPUSwizle.h"
#import "AMPUTokenStorage.h"
#import "AMPUAppMetricaConfigStorage.h"

static void ampu_swizleUnityAppController();
static bool ampu_ensureAppMetricaActivated();

__attribute__((constructor))
static void ampu_initializeAppMetricaPushPlugin()
{
    ampu_swizleUnityAppController();
}

@implementation UnityAppController (AMPUAppMetricaPushAppController)

#define RECURSION_CHECK(CMD) if ([NSStringFromSelector(_cmd) rangeOfString:@"ampu_"].location == 0) { CMD; }

- (BOOL)ampu_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    RECURSION_CHECK(return YES);
    
    // Call the original method
    BOOL result = [self ampu_application:application didFinishLaunchingWithOptions:launchOptions];
    
    // Enable in-app push notifications handling in iOS 10
    if ([UNUserNotificationCenter class] != nil) {
        id<AMPUserNotificationCenterDelegate> delegate = [AMPAppMetricaPush userNotificationCenterDelegate];
        delegate.nextDelegate = [UNUserNotificationCenter currentNotificationCenter].delegate;
        [UNUserNotificationCenter currentNotificationCenter].delegate = delegate;
    }
    
    if (ampu_ensureAppMetricaActivated()) {
        [AMPAppMetricaPush handleApplicationDidFinishLaunchingWithOptions:launchOptions];
    }
    
    return result;
}

- (void)ampu_application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    RECURSION_CHECK(return);
    
    if (ampu_ensureAppMetricaActivated()) {
#ifdef DEBUG
        AMPAppMetricaPushEnvironment pushEnvironment = AMPAppMetricaPushEnvironmentDevelopment;
#else
        AMPAppMetricaPushEnvironment pushEnvironment = AMPAppMetricaPushEnvironmentProduction;
#endif
        [AMPAppMetricaPush setDeviceTokenFromData:deviceToken pushEnvironment:pushEnvironment];
    }
    [AMPUTokenStorage saveToken:deviceToken];
    
    // Call the original method
    [self ampu_application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)ampu_application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    RECURSION_CHECK(return);
    
    if (ampu_ensureAppMetricaActivated()) {
        [AMPAppMetricaPush handleRemoteNotification:userInfo];
    }
    
    // Call the original method
    [self ampu_application:application didReceiveRemoteNotification:userInfo];
}

- (void)ampu_application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    RECURSION_CHECK(return);
    
    if (ampu_ensureAppMetricaActivated()) {
        [AMPAppMetricaPush handleRemoteNotification:userInfo];
    }
    
    // Call the original method
    [self ampu_application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
}

@end

static bool ampu_ensureAppMetricaActivated()
{
    if (AMAAppMetrica.isActivated) return YES;
    char *config = [AMPUAppMetricaConfigStorage loadConfig];
    [AMAUAppMetricaPushHelper activateAppMetricaByUnityConfig:config];
    return NO;
}

static void ampu_swizleUnityAppController()
{
    #pragma clang diagnostic push
    #pragma clang diagnostic error "-Wundeclared-selector"

    #define SWAP_APPDELEGATE_METHODS(SEL) ampu_unityAppControllerMethodsSwap(@selector(SEL), @selector(ampu_ ## SEL))

    SWAP_APPDELEGATE_METHODS(application:didFinishLaunchingWithOptions:);
    SWAP_APPDELEGATE_METHODS(application:didRegisterForRemoteNotificationsWithDeviceToken:);
    SWAP_APPDELEGATE_METHODS(application:didReceiveRemoteNotification:);
    SWAP_APPDELEGATE_METHODS(application:didReceiveRemoteNotification:fetchCompletionHandler:);

    #undef SWAP_APPDELEGATE_METHODS
    #pragma clang diagnostic pop
}
