namespace BasicMeterSettings
{

    // Background
    [Setting hidden]
    bool BasicMeterBackgroundVisible = true;

    [Setting hidden]
    string BasicMeterBackgroundURL = "file:///C:/Users/napps/OpenplanetNext/Plugins/Altimeter/Resources/Altimeter.png";

    [Setting hidden]
    float BasicMeterBackgroundScale = 0.325f;

    [Setting hidden]
    float BasicMeterBackgroundAlpha = 1.0f;

    void ResetAllToDefault() {
        BasicMeterBackgroundVisible = true;
        BasicMeterBackgroundURL = "file:///C:/Users/napps/OpenplanetNext/Plugins/Altimeter/Resources/Altimeter.png";
        BasicMeterBackgroundScale = 0.325f;
        BasicMeterBackgroundAlpha = 1.0f;
    }
}