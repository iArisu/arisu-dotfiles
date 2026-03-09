import Quickshell
import QtQuick
import Qt5Compat.GraphicalEffects

import qs.visuals 

PanelWindow {
    id: root
    implicitHeight: Screen.height
    implicitWidth: Screen.width
    aboveWindows: false
    
    anchors {
        top: true
        left: true
        right: true
        bottom: true
    }
    margins {
        left: 0
        top: 0
        right: 0
        bottom: 0
    }
    color: "transparent"

    Rectangle {
        x: 0
        y: 0
        anchors.fill: parent
        color: Appearance.topbar_bg
        layer.enabled: true

        layer.effect: OpacityMask {
            invert: true
            maskSource: Rectangle {
                width: Screen.width
                height: Screen.height
                radius: 30
                color: "white"
            }
        }
    }
}