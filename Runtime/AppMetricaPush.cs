using Io.AppMetrica.Push.Native;
using JetBrains.Annotations;

#if UNITY_ANDROID && !UNITY_EDITOR
using Io.AppMetrica.Push.Native.Android;
#elif (UNITY_IPHONE || UNITY_IOS) && !UNITY_EDITOR
using Io.AppMetrica.Push.Native.Ios;
#else
using Io.AppMetrica.Push.Native.Dummy;
#endif

namespace Io.AppMetrica.Push {
    public static class AppMetricaPush {
        [NotNull]
        private static readonly IAppMetricaPushNative Native;

        [CanBeNull]
        public static string Token => Native.Token;

        static AppMetricaPush() {
#if UNITY_ANDROID && !UNITY_EDITOR
            Native = new AppMetricaPushAndroid();
#elif (UNITY_IPHONE || UNITY_IOS) && !UNITY_EDITOR
            Native = new AppMetricaPushIos();
#else
            Native = new AppMetricaPushDummy();
#endif
        }

        public static void Activate() {
            Native.Activate();
            SaveAppMetricaConfig();
        }

        private static void SaveAppMetricaConfig() {
            AppMetrica.OnActivation += SaveAppMetricaConfig;

            var config = AppMetrica.ActivationConfig;
            if (config != null) {
                SaveAppMetricaConfig(config);
            }
        }

        private static void SaveAppMetricaConfig([NotNull] AppMetricaConfig config) {
            Native.SaveAppMetricaConfig(config.ToJsonString());
        }
    }
}
