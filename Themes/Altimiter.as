class Altimiter : Meter
{
    float startAngle = 0.0f;
    float angleTotal = 2.0f * Math::PI;

    Altimiter()
    {
        super();
    }

    void RenderBackground() override
    {
        if (!BasicMeterSettings::BasicMeterBackgroundVisible) return;

        auto image = Images::CachedFromURL(BasicMeterSettings::BasicMeterBackgroundURL);
        if (image.m_texture is null) return;

        nvg::BeginPath();
        vec2 imageSize = image.m_texture.GetSize() * BasicMeterSettings::BasicMeterBackgroundScale;
        vec2 imageCenterPos = vec2(imageSize.x / 2.0f, imageSize.y / 2.0f);
        nvg::Rect(m_center - imageCenterPos, imageSize);
        nvg::FillPaint(nvg::TexturePattern(m_center - imageCenterPos, imageSize, 0, image.m_texture, BasicMeterSettings::BasicMeterBackgroundAlpha));
        nvg::Fill();
        nvg::ClosePath();
    }

    void RenderImagePointer(string imageUrl, float scaleModifier) override
    {
        auto image = Images::CachedFromURL(imageUrl);
        if (image.m_texture is null) return;

        vec2 imageSize = image.m_texture.GetSize() * BasicMeterSettings::BasicMeterBackgroundScale;
        vec2 realImageSize = image.m_texture.GetSize();
        vec2 imageCenterPos = vec2(imageSize.x / 2.0f, imageSize.y / 2.0f);

        // Remember to revert these after drawing
        nvg::Translate(m_center);
        nvg::Rotate(angleTotal * m_altitude * scaleModifier);

        nvg::BeginPath();
        nvg::FillPaint(nvg::TexturePattern(vec2(0,0) - imageCenterPos, imageSize, .0f, image.m_texture, BasicMeterSettings::BasicMeterBackgroundAlpha));
        nvg::Fill();
        nvg::ClosePath();

        // Revert rotation and translation to draw next item in the correct place
        nvg::Rotate(0 - angleTotal * m_altitude * scaleModifier);
        nvg::Translate(0-m_center);
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
        UI::EndTabBar();
    }
}