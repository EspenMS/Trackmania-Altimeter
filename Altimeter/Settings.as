namespace AltimeterSettings
{

    // Background
    [Setting hidden]
    bool AltimeterBackgroundVisible = true;

    [Setting hidden]
    string AltimeterBackgroundURL = "file:///C:/Users/napps/OpenplanetNext/Plugins/Altimeter/Resources/Altimeter.png";

    [Setting hidden]
    float AltimeterBackgroundScale = 0.325f;

    [Setting hidden]
    float AltimeterBackgroundAlpha = 1.0f;

    void ResetAllToDefault() {
        AltimeterBackgroundVisible = true;
        AltimeterBackgroundURL = "file:///C:/Users/napps/OpenplanetNext/Plugins/Altimeter/Resources/Altimeter.png";
        AltimeterBackgroundScale = 0.325f;
        AltimeterBackgroundAlpha = 1.0f;
    }
}