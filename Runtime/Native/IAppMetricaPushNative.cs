using JetBrains.Annotations;

namespace Io.AppMetrica.Push.Native {
    internal interface IAppMetricaPushNative {
        [CanBeNull]
        string Token { get; }

        void Activate();

        void SaveAppMetricaConfig([NotNull] string appMetricaConfig);
    }
}
