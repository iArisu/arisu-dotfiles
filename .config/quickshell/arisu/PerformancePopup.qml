import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs.utils

Item {
    //anchors.verticalCenter: parent.verticalCenter
    Layout.alignment: Qt.AlignVCenter
    implicitWidth: panel.width
    implicitHeight: panel.height

    RowLayout {
        id: panel
        anchors.margins: 8
        spacing: 12
        
        // TODO: either delete or merge with "metrics chips"
        Text {
            text: "システム情報"
            color: "#7aa2f7"
            font {
                family: "JetBrainsMono Nerd Font";
                pixelSize: 14;
                bold: true
            }

            MouseArea {
                width: panel.width
                height: panel.height
                
                hoverEnabled: true
                onEntered: {
                    dropdownPopup.visible = true
                }
                onExited: {
                    dropdownPopup.visible = false
                }
            }
        }
    }

    PopupWindow {
        id: dropdownPopup
        anchor.window: root
        anchor.rect.x: root.width - 200
        anchor.rect.y: root.height + 10
        implicitWidth: 200
        implicitHeight: 100
        visible: false
        color: "transparent"

        Rectangle {
            anchors.fill: parent
            color: '#b7626262'   // translucent with alpha
            radius: 12
            layer.enabled: true       // enables native blur / translucency on supported compositor
            layer.smooth: true

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 12
                spacing: 8

                Text { text: "CPU: " + Math.floor(ResourceUsage.cpuUsage * 100) + "%"; color: "#e0af68"; font.pixelSize: 14 }
                Text { text: "Mem: " + Math.floor(ResourceUsage.memoryUsedPercentage * 100) + "%"; color: "#0db9d7"; font.pixelSize: 14 }
                //Text { text: "Clock: " + clock.text; color: "#7aa2f7"; font.pixelSize: 14 }
            }
        }
    }
}