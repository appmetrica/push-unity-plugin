using JetBrains.Annotations;

namespace Io.AppMetrica.Push.Native.Dummy {
    internal class AppMetricaPushDummy : IAppMetricaPushNative {
        [CanBeNull]
        public string Token => null;

        public void Activate() { }

        public void SaveAppMetricaConfig(string appMetricaConfig) { }
    }
}
