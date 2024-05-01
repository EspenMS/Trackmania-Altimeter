class Cockpit
{
    Meter@ m_meter;

    Cockpit()
    {
        UpdateMeterTheme();
    }

    void UpdateMeterTheme()
    {
        switch(PluginSettings::Theme)
        {
            case PluginSettings::Themes::Basic:
                @m_meter = BasicMeter();
                break;
            default:
                @m_meter = Meter();
                break;
        }
    }

    void Render()
    {
        if (!PluginSettings::ShowAltimeter) return;

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

        m_meter.m_pos = PluginSettings::Position;
        m_meter.m_size = PluginSettings::Size;

        m_meter.InternalRender(visState);
    }
}