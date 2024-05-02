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
        if (!AltimeterSettings::AltimeterBackgroundVisible) return;

        auto image = Images::CachedFromURL(AltimeterSettings::AltimeterBackgroundURL);
        if (image.m_texture is null) return;

        nvg::BeginPath();
        vec2 imageSize = image.m_texture.GetSize() * AltimeterSettings::AltimeterBackgroundScale;
        vec2 imageCenterPos = vec2(imageSize.x / 2.0f, imageSize.y / 2.0f);
        nvg::Rect(m_center - imageCenterPos, imageSize);
        nvg::FillPaint(nvg::TexturePattern(m_center - imageCenterPos, imageSize, 0, image.m_texture, AltimeterSettings::AltimeterBackgroundAlpha));
        nvg::Fill();
        nvg::ClosePath();
    }

    void RenderImagePointer(string imageUrl, float scaleModifier) override
    {
        auto image = Images::CachedFromURL(imageUrl);
        if (image.m_texture is null) return;

        vec2 imageSize = image.m_texture.GetSize() * AltimeterSettings::AltimeterBackgroundScale;
        vec2 realImageSize = image.m_texture.GetSize();
        vec2 imageCenterPos = vec2(imageSize.x / 2.0f, imageSize.y / 2.0f);

        // Remember to revert these after drawing
        nvg::Translate(m_center);
        nvg::Rotate(angleTotal * m_altitude * scaleModifier);

        nvg::BeginPath();
        nvg::FillPaint(nvg::TexturePattern(vec2(0,0) - imageCenterPos, imageSize, .0f, image.m_texture, AltimeterSettings::AltimeterBackgroundAlpha));
        nvg::Fill();
        nvg::ClosePath();

        // Revert rotation and translation to draw next item in the correct place
        nvg::Rotate(0 - angleTotal * m_altitude * scaleModifier);
        nvg::Translate(0-m_center);
    }

    void RenderSettingsTab() override
    {
        if (UI::Button("Reset all settings to default")) {
            AltimeterSettings::ResetAllToDefault();
        }
        UI::BeginTabBar("Altimeter Settings", UI::TabBarFlags::FittingPolicyResizeDown);
        if (UI::BeginTabItem("Background")) {
            UI::BeginChild("Background Settings");
            AltimeterSettings::AltimeterBackgroundVisible = UI::Checkbox("Display background", AltimeterSettings::AltimeterBackgroundVisible);

            if (AltimeterSettings::AltimeterBackgroundVisible) {
                AltimeterSettings::AltimeterBackgroundURL = UI::InputText("Image URL", AltimeterSettings::AltimeterBackgroundURL);
                AltimeterSettings::AltimeterBackgroundAlpha = UI::SliderFloat("Alpha", AltimeterSettings::AltimeterBackgroundAlpha,0,1);
                AltimeterSettings::AltimeterBackgroundScale = UI::SliderFloat("Scale", AltimeterSettings::AltimeterBackgroundScale,0.1f,1.0f);
           }

            UI::EndChild();
            UI::EndTabItem();
        }
        UI::EndTabBar();
    }
}