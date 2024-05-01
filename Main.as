Cockpit@ g_cockpit;

void Main()
{
    @g_cockpit = Cockpit();
}


void RenderMenu()
{
    if(UI::MenuItem("\\$fff" + Icons::Clock + " \\$zAltimeter", "", PluginSettings::ShowAltimeter))
        PluginSettings::ShowAltimeter = !PluginSettings::ShowAltimeter;
}

void Render()
{
  g_cockpit.Render();
}

void OnSettingsChanged()
{
    g_cockpit.UpdateMeterTheme();
    g_cockpit.UpdateUnit();
}


void RenderInterface()
{
    if (PluginSettings::LocatorMode) {
        Locator::Render("Altimeter", PluginSettings::Position, PluginSettings::Size);
        PluginSettings::Position = Locator::GetPos();
        PluginSettings::Size = Locator::GetSize();
    }
}