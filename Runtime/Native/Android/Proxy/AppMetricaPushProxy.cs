#if UNITY_ANDROID
using JetBrains.Annotations;
using UnityEngine;

namespace Io.AppMetrica.Push.Native.Android.Proxy {
    internal static class AppMetricaPushProxy {
        private static readonly AndroidJavaClass NativeClass = new AndroidJavaClass("io.appmetrica.analytics.push.plugin.unity.AppMetricaPushProxy");

        public static void Activate() {
            NativeClass.CallStatic("activate");
        }

        [CanBeNull]
        public static string GetToken() {
            return NativeClass.CallStatic<string>("getToken");
        }

        public static void SaveAppMetricaConfig([NotNull] string appMetricaConfig) {
            NativeClass.CallStatic("saveAppMetricaConfig", appMetricaConfig);
        }
    }
}
#endif
