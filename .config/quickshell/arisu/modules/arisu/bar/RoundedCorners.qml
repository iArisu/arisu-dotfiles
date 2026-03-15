import Quickshell
import QtQuick
import Qt5Compat.GraphicalEffects

import qs.services

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
        id: bgRect
        x: 0
        y: 0
        anchors.fill: parent
        color: Appearance.topbar_bg
        layer.enabled: true

        visible: true

        property int targetRadius: !Config.topbar_detached ? 30 : 0
        property int targetRadiusAnimation: !Config.topbar_detached ? 50 : 300   // appear 0.3s, disappear 0.1s

        layer.effect: OpacityMask {
            invert: true
            maskSource: Rectangle {
                width: Screen.width
                height: Screen.height
                radius: bgRect.targetRadius
                color: "white"
            }
        }

        Behavior on targetRadius {
            NumberAnimation {
                duration: targetRadiusAnimation
                easing.type: Easing.InOutQuad
            }
        }
    }
}