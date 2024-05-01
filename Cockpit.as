class Cockpit
{
    Gauge@ m_gauge;

    Cockpit()
    {
        UpdateGaugeTheme();
    }

    void UpdateGaugeTheme()
    {
        switch(PluginSettings::Theme)
        {
            case PluginSettings::Themes::Basic:
                @m_gauge = BasicGauge();
                break;
            default:
                @m_gauge = Gauge();
                break;
        }
    }

    void Render()
    {
        if (!PluginSettings::ShowSpeedometer) return;

        if (PluginSettings::HideWhenNotIFace && !UI::IsGameUIVisible()) return;

        auto app = GetApp();

        if (PluginSettings::HideWhenNotPlaying) {
            if (app.CurrentPlayground !is null && (app.CurrentPlayground.UIConfigs.Length > 0)) {
                if (app.CurrentPlayground.UIConfigs[0].UISequence == CGamePlaygroundUIConfig::EUISequence::Intro) {
                    return;
                }
            }
        }

        auto visState = VehicleState::ViewingPlayerState();
        if (visState is null) return;

        m_gauge.m_pos = PluginSettings::Position;
        m_gauge.m_size = PluginSettings::Size;

        m_gauge.InternalRender(visState);
    }
}