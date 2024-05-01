class Gauge
{
    vec2 m_pos;
    vec2 m_size;

    vec2 m_resPos;
    vec2 m_center;

    float m_altitude = 0.0f;

    void InternalRender(CSceneVehicleVisState@ vis)
    {
        m_altitude = vis.Position.y * (1 == 1 ? 3.28084f : 1);

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
        RenderAltitude();

        RenderPointer(0.0001, true, vec4(.8f, .8f, .85f, 1.0f), 0.01, .4);
        RenderPointer(0.001, true, vec4(.8f, .8f, .85f, 1.0f), 0.02, .3);
        RenderPointer(0.01, true, vec4(.8f, .8f, .85f, 1.0f), 0.03, .2);

        RenderMiddle();
    }

    void RenderBackground(){}

    void RenderMiddle(){}

    void RenderAltitude(){}

    void RenderPointer(float scaleModifyer, bool showPointer, vec4 color, float width, float length){}

    void RenderSettingsTab() {
        UI::Text("This theme does not have any settings.");
    }
}