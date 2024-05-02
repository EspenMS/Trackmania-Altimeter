namespace AltimeterSettings
{

    // Background
    [Setting hidden]
    bool AltimeterBackgroundVisible = true;

    [Setting hidden]
    string AltimeterBackgroundURL = "https://i.imgur.com/f0ly2Pc.png";

    [Setting hidden]
    float AltimeterBackgroundScale = 0.325f;

    [Setting hidden]
    float AltimeterBackgroundAlpha = 1.0f;

    void ResetAllToDefault() {
        AltimeterBackgroundVisible = true;
        AltimeterBackgroundURL = "https://i.imgur.com/f0ly2Pc.png";
        AltimeterBackgroundScale = 0.325f;
        AltimeterBackgroundAlpha = 1.0f;
    }
}