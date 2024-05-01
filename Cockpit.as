class Cockpit
{
    Meter@ m_meter;
    float m_unit;

    Cockpit()
    {
        UpdateMeterTheme();
        UpdateUnit();
    }

    void UpdateMeterTheme()
    {
        switch(PluginSettings::Theme)
        {
            case PluginSettings::Themes::Basic:
                @m_meter = Altimiter();
                break;
            default:
                @m_meter = Altimiter();
                break;
        }
    }

    void UpdateUnit()
    {
        switch(PluginSettings::Unit)
        {
            case PluginSettings::Units::Meters:
                m_unit = 1.0f;
                break;
            case PluginSettings::Units::Feet:
                m_unit = 3.28084f;
                break;
            default:
                m_unit = 3.28084f;
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

        m_meter.InternalRender(visState, m_unit);
    }
}