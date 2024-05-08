#if UNITY_IPHONE || UNITY_IOS
using JetBrains.Annotations;
using System.Runtime.InteropServices;

namespace Io.AppMetrica.Push.Native.Ios.Proxy {
    internal static class AppMetricaPushProxy {
        [DllImport("__Internal")]
        public static extern void ampu_activate();
        
        [DllImport("__Internal")]
        public static extern string ampu_getToken();

        [DllImport("__Internal")]
        public static extern void ampu_saveAppMetricaConfig([NotNull] string appMetricaConfig);
    }
}
#endif
