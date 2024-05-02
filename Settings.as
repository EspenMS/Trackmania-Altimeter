namespace PluginSettings
{
    [Setting name="Show Altimeter" category="General"]
    bool ShowAltimeter = true;

    [Setting name="Hide when not playing" category="General"]
    bool HideWhenNotPlaying = true;

    [Setting name="Hide when interface is hidden" category="General"]
    bool HideWhenNotIFace = false;

    [Setting name="Locator Mode (move Altimeter)" category="General"]
    bool LocatorMode = false;

    enum Units {
        Feet,
        Meters
    }

    [Setting name="Unit" category="General"]
    Units Unit = Units::Feet;

    [Setting name="Position" category="General"]
    vec2 Position = vec2(1.0f, 1.06f);

    [Setting name="Size" category="General"]
    vec2 Size = vec2(350, 350);

    [SettingsTab name="Display settings"]
    void RenderThemeSettingsTab()
    {
        g_cockpit.m_meter.RenderSettingsTab();
    }
}