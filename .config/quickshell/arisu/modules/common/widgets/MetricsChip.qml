import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Shapes
import Qt5Compat.GraphicalEffects

import qs.services
import qs.modules.common.functions

RowLayout {
    id: root

    readonly property color primaryColor: Appearance.computer_metrics_text
    readonly property color secondaryColor: Appearance.computer_metrics_fg
    readonly property color backgroundColor: Appearance.computer_metrics_bg

    required property real percentage
    required property string icon

    // one decimal more for precision? seems to be required to reach 0
    property real percentageStable: Animations.nearQML(percentage, 3)
    spacing: 5

    Rectangle {
        id: metrics_chip

        height: 24
        width: 24
        radius: 64

        color: backgroundColor

        Item {
            id: circleBar
            
            property real percentageGPUFriendly: Math.max(0.0001, Math.min(0.9999, percentageStable))

            width: metrics_chip.width
            height: metrics_chip.height

            Rectangle {
                id: circleMask
                anchors.fill: parent
                radius: width / 2
                visible: false
            }

            ConicalGradient {
                id: gradient
                anchors.fill: parent
                angle: 0
                visible: false

                gradient: Gradient {
                    GradientStop { position: 0.0; color: Appearance.computer_metrics_fill }
                    GradientStop { position: circleBar.percentageGPUFriendly; color: Appearance.computer_metrics_fill }
                    GradientStop { position: circleBar.percentageGPUFriendly + 0.001; color: "transparent" }
                    GradientStop { position: 1.0; color: "transparent" }
                }
            }

            OpacityMask {
                anchors.fill: parent
                source: gradient
                maskSource: circleMask
            }
        }
        
        MaterialSymbol {
            anchors.centerIn: parent
            iconSize: 18
            text: root.icon
            color: secondaryColor
        }
    }

    Text {
        id: metrics_chip_text
        text: String(Math.floor(root.percentageStable * 100)).padEnd(2, " ")
        color: primaryColor
        font: Appearance.defaultFont_bold
    }
}