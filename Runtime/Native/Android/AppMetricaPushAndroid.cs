#if UNITY_ANDROID
using Io.AppMetrica.Push.Native.Android.Proxy;
using JetBrains.Annotations;

namespace Io.AppMetrica.Push.Native.Android {
    internal class AppMetricaPushAndroid : IAppMetricaPushNative {
        public string Token => AppMetricaPushProxy.GetToken();

        public void Activate() {
            AppMetricaPushProxy.Activate();
        }

        public void SaveAppMetricaConfig([NotNull] string appMetricaConfig) {
            AppMetricaPushProxy.SaveAppMetricaConfig(appMetricaConfig);
        }
    }
}
#endif
