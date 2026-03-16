import QtQuick
import QtQuick.Effects

MultiEffect {
    property bool apply: true

    // Appearance.colWorkspaceSwitcher_icon_tint
    required property color tint

    // 1 means fully tinted, 0 is no tint
    property real enabled_force: 0.5
    property real disabled_force: 0

    colorization: apply ? enabled_force : 1 - disabled_force
    colorizationColor: tint
    
    Behavior on colorization {
        NumberAnimation {
            duration: 200;
            easing.type: Easing.InOutCubic
        }
    }
}