package io.appmetrica.analytics.push.plugin.unity;

import android.app.Activity;
import android.util.Log;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import com.unity3d.player.UnityPlayer;
import org.json.JSONException;
import java.util.Map;
import io.appmetrica.analytics.AppMetricaConfig;
import io.appmetrica.analytics.plugin.unity.AppMetricaPushHelper;
import io.appmetrica.analytics.push.AppMetricaPush;
import io.appmetrica.analytics.push.plugin.adapter.internal.AppMetricaConfigStorage;

public final class AppMetricaPushProxy {
    private AppMetricaPushProxy() {}

    public static void activate() {
        AppMetricaPush.activate(getActivity());
    }

    @Nullable
    public static String getToken() {
        Map<String, String> tokens = AppMetricaPush.getTokens();
        if (tokens == null) return null;
        return tokens.get("firebase");
    }

    public static void saveAppMetricaConfig(@NonNull String appMetricaConfig) {
        try {
            AppMetricaConfig config = AppMetricaPushHelper.getAppMetricaConfigFromUnityJsonString(appMetricaConfig);
            AppMetricaConfigStorage.saveConfig(getActivity(), config.toJson());
        } catch (JSONException e) {
            Log.e("AppMetricaPushUnity", "Failed to save AppMetrica config", e);
        }
    }

    @NonNull
    private static Activity getActivity() {
        // TODO: check UnityPlayer.currentActivity != null
        return UnityPlayer.currentActivity;
    }
}
