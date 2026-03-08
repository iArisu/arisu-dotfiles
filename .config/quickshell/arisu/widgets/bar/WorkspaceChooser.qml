import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs.visuals

Item {
    implicitHeight: wkRow.implicitHeight + 4
    implicitWidth: wkRow.implicitWidth + 4

    Rectangle {
        anchors.fill: parent
        radius: 16
        color: Appearance.colWorkspaceSwitcher_bg
    }

    // Sliding active indicator
    Rectangle {
        id: highlight
        width: 24
        height: 24
        radius: 64
        color: Appearance.colWorkspaceSwitcher_active_bg

        y: (parent.height - height) / 2
        x: ((root.selectedWorkspace - 1) % workspacesPerPage + 1) * 28 - 28 + 2 // padding, see Item implicitWidth+4


        Behavior on x {
            NumberAnimation {
                duration: 220
                easing.type: Easing.OutCubic
            }
        }
    }

    RowLayout {
        id: wkRow
        spacing: 4
        anchors.centerIn: parent //padding

        Repeater {
            model: workspacesPerPage

            Item {
                id: wsBox
                width: 24
                height: 24

                property bool active: root.selectedWorkspace === (index + 1)
                property bool hovered: false

                Text {
                    anchors.centerIn: parent
                    text: (workspacePage * workspacesPerPage) + index + 1
                    color: wsBox.active ? 
                        Appearance.colWorkspaceSwitcher_active_fg :
                        Appearance.colWorkspaceSwitcher_fg
                    font { family: Appearance.fontFamily; pixelSize: Appearance.fontSize; bold: true }
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: wsBox.hovered = true
                    onExited: wsBox.hovered = false
                    onClicked: {
                        //root.selectedWorkspace = index + 1
                        Hyprland.dispatch("workspace " + (index + 1))
                    }
                }
            }
        }
    }
}   