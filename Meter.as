class Meter
{
    vec2 m_pos;
    vec2 m_size;

    vec2 m_resPos;
    vec2 m_center;

    float m_altitude = 0.0f;

    void InternalRender(CSceneVehicleVisState@ vis, float m_conversionFactor)
    {
        m_altitude = vis.Position.y * m_conversionFactor;

        vec2 screenSize = vec2(Draw::GetWidth(), Draw::GetHeight());
		m_resPos = m_pos * (screenSize - m_size);
        m_center = vec2(m_size.x * 0.5f, m_size.y * 0.5f);
		nvg::Translate(m_resPos.x, m_resPos.y);
		Render();
		nvg::ResetTransform();
    }

    void Render()
    {
        RenderBackground();
        
        RenderImagePointer("https://i.imgur.com/ZTNPyb7.png", .0001f);
        RenderImagePointer("https://i.imgur.com/ES3KSXr.png", .001f);
        RenderImagePointer("https://i.imgur.com/UJCabwQ.png", .01f);
    }

    void RenderBackground(){}

    void RenderImagePointer(string imageUrl, float scaleModifier){}

    void RenderSettingsTab() {
        UI::Text("This theme does not have any settings.");
    }
}