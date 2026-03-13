import QtQuick

import qs.utils

StyledText {
    id: root
    property real iconSize: 16
    property real fill: 0

    // Reduce memory consumption spikes from constant font remapping
    //property real truncatedFill: fill.toFixed(1)
    property real truncatedFill: Animations.nearQML(fill) // seems better

    renderType: Text.NativeRendering
    font {
        hintingPreference: Font.PreferNoHinting
        family: "Material Symbols Rounded"
        pixelSize: iconSize
        weight: Font.Normal + (Font.DemiBold - Font.Normal) * truncatedFill
        variableAxes: { 
            "FILL": truncatedFill,
            // "wght": font.weight,
            // "GRAD": 0,
            "opsz": iconSize,
        }
    }

    // Leaky leaky, no good
    Behavior on fill {
        NumberAnimation {
            duration: 200
            easing.type: Easing.BezierSpline
            easing.bezierCurve: [0.34, 0.80, 0.34, 1.00, 1, 1]
        }
    }
}