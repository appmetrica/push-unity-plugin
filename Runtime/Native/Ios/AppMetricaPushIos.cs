#if UNITY_IPHONE || UNITY_IOS
using Io.AppMetrica.Push.Native.Ios.Proxy;
using JetBrains.Annotations;

namespace Io.AppMetrica.Push.Native.Ios {
    internal class AppMetricaPushIos : IAppMetricaPushNative {
        public string Token => AppMetricaPushProxy.ampu_getToken();

        public void Activate() {
            AppMetricaPushProxy.ampu_activate();
        }

        public void SaveAppMetricaConfig([NotNull] string appMetricaConfig) {
            AppMetricaPushProxy.ampu_saveAppMetricaConfig(appMetricaConfig);
        }
    }
}
#endif
