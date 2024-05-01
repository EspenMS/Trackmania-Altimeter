namespace BasicGaugeSettings
{

    // Background
    [Setting hidden]
    bool BasicGaugeBackgroundVisible = true;

    [Setting hidden]
    string BasicGaugeBackgroundURL = "file:///C:/Users/napps/Downloads/Altimeter.png";

    [Setting hidden]
    float BasicGaugeBackgroundScale = 0.325f;

    [Setting hidden]
    float BasicGaugeBackgroundAlpha = 1.0f;

    // Pointers
    // Pointer visibility
    [Setting hidden]
    bool BasicTensPointer = true;

    [Setting hidden]
    bool BasicHundredsPointer = true;

    [Setting hidden]
    bool BasicThousandsPointer = true;

    // Pointer color
    [Setting hidden]
    vec4 BasicTensPointerColor = vec4(1.0f, 1.0f, 1.0f, 1.0f);

    [Setting hidden]
    vec4 BasicHundredsPointerColor = vec4(1.0f, 1.0f, 1.0f, 1.0f);

    [Setting hidden]
    vec4 BasicThousandssPointerColor = vec4(1.0f, 1.0f, 1.0f, 1.0f);

    // Pointer width
    [Setting hidden]
    float BasicTensPointerWidth = 0.011f;
    
    [Setting hidden]
    float BasicHundredsPointerWidth = 0.011f;

    [Setting hidden]
    float BasicThousandsPointerWidth = 0.011f;

    void ResetAllToDefault() {
        BasicGaugeBackgroundVisible = true;
        BasicGaugeBackgroundURL = "file:///C:/Users/napps/Downloads/Altimeter.png";
        BasicGaugeBackgroundScale = 0.325f;
        BasicGaugeBackgroundAlpha = 1.0f;

        // Pointers
        BasicTensPointerColor = vec4(1.0f, 1.0f, 1.0f, 1.0f);
        BasicTensPointer = true;
        BasicHundredsPointer = true;
        BasicThousandsPointer = true;

        BasicTensPointerWidth = 0.011f;
    }
}