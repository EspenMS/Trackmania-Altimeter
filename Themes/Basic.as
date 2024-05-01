class Altimiter : Meter
{
    float startAngle = -90.0f;
    float angleTotal = 360.0f;

    Altimiter()
    {
        super();
    }

    void RenderBackground() override
    {
        if (BasicMeterSettings::BasicMeterBackgroundVisible) {
            auto image = Images::CachedFromURL(BasicMeterSettings::BasicMeterBackgroundURL);
            if (image.m_texture !is null){
                nvg::BeginPath();
                vec2 imageSize = image.m_texture.GetSize() * BasicMeterSettings::BasicMeterBackgroundScale;
                vec2 imageCenterPos = vec2(imageSize.x / 2.0f, imageSize.y / 2.0f);
                nvg::Rect(m_center - imageCenterPos, imageSize);
                nvg::FillPaint(nvg::TexturePattern(m_center - imageCenterPos, imageSize, 0, image.m_texture, BasicMeterSettings::BasicMeterBackgroundAlpha));
                nvg::Fill();
                nvg::ClosePath();
            }
        }
    }

    void RenderAltitude() override
    {
        nvg::BeginPath();
        nvg::FontSize(m_size.x * 0.2f);
        // remove negative sign
        int altitude = Text::ParseInt(Text::Format("%.0f", m_altitude));
        vec2 margin = vec2(m_size.x * 0.07f, 60 + (m_size.y * 0.1f) - 250);

        nvg::FillColor(vec4(1.0f, 1.0f, 1.0f, 1.0f));
        nvg::Text(m_center.x+margin.x, m_center.y+margin.y, Text::Format("%04d", altitude));

        nvg::ClosePath();
    }

    void RenderMiddle() override
    {
        nvg::BeginPath();
        nvg::Circle(m_center, .02f * m_size.x);
        nvg::FillColor(vec4(.8f, .8f, .8f, 1.0f));
        nvg::Fill();
        nvg::ClosePath();
    }

    void RenderPointer(float scaleModifyer, bool showPointer, vec4 color, float width, float length) override
    {
        if (showPointer) {
            nvg::BeginPath();
            nvg::StrokeWidth(m_size.x * width);
            float startBase = 8;
            float xs = m_center.x + Math::Cos(Utils::DegToRad(startAngle + (angleTotal * (m_altitude * scaleModifyer))));
            float ys = m_center.y + Math::Sin(Utils::DegToRad(startAngle + (angleTotal * (m_altitude * scaleModifyer))));
            float xe = m_center.x + (m_size.x*length) * Math::Cos(Utils::DegToRad(startAngle + (angleTotal * (m_altitude * scaleModifyer))));
            float ye = m_center.y + (m_size.x*length) * Math::Sin(Utils::DegToRad(startAngle + (angleTotal * (m_altitude * scaleModifyer))));
            nvg::MoveTo(vec2(xs, ys));
            nvg::LineTo(vec2(xe, ye));

            nvg::StrokeColor(color);

            nvg::Stroke();
            nvg::ClosePath();
        }
    }



    void RenderSettingsTab() override
    {
        if (UI::Button("Reset all settings to default")) {
            BasicMeterSettings::ResetAllToDefault();
        }
        UI::BeginTabBar("Basic Meter Settings", UI::TabBarFlags::FittingPolicyResizeDown);
        if (UI::BeginTabItem("Background")) {
            UI::BeginChild("Background Settings");
            BasicMeterSettings::BasicMeterBackgroundVisible = UI::Checkbox("Display background", BasicMeterSettings::BasicMeterBackgroundVisible);

            if (BasicMeterSettings::BasicMeterBackgroundVisible) {
                BasicMeterSettings::BasicMeterBackgroundURL = UI::InputText("Image URL", BasicMeterSettings::BasicMeterBackgroundURL);
                BasicMeterSettings::BasicMeterBackgroundAlpha = UI::SliderFloat("Alpha", BasicMeterSettings::BasicMeterBackgroundAlpha,0,1);
                BasicMeterSettings::BasicMeterBackgroundScale = UI::SliderFloat("Scale", BasicMeterSettings::BasicMeterBackgroundScale,0.1f,0.5f);
           }

            UI::EndChild();
            UI::EndTabItem();
        }
        if (UI::BeginTabItem("Pointers")) {
            UI::BeginChild("Pointer Settings");
            BasicMeterSettings::BasicTensPointerColor = UI::InputColor4("RPM Color", BasicMeterSettings::BasicTensPointerColor);

            BasicMeterSettings::BasicTensPointer = UI::Checkbox("Pointer", BasicMeterSettings::BasicTensPointer);
            if (BasicMeterSettings::BasicTensPointer)
                BasicMeterSettings::BasicTensPointerWidth = UI::SliderFloat("Pointer width", BasicMeterSettings::BasicTensPointerWidth,0,0.1);

            UI::EndChild();
            UI::EndTabItem();
        }
        UI::EndTabBar();
    }
}