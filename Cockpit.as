class Cockpit
{
    Meter@ m_meter = Altimiter();
    float m_unitConversionFactor;

    Cockpit()
    {
        UpdateUnit();
    }

    void UpdateUnit()
    {
        switch(PluginSettings::Unit)
        {
            case PluginSettings::Units::Meters:
                m_unitConversionFactor = 1.0f;
                break;
            case PluginSettings::Units::Feet:
                m_unitConversionFactor = 3.28084f;
                break;
            default:
                m_unitConversionFactor = 3.28084f;
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

        m_meter.InternalRender(visState, m_unitConversionFactor);
    }
}