import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs.modules.common.widgets
import qs.services

Rectangle {
    id: root

    required property string icon
    required property var onClicked

    readonly property color primaryColor: Appearance.colWorkspaceSwitcher_fg
    readonly property color backgroundColor: Appearance.colWorkspaceSwitcher_bg

    height: 24
    width: 24
    radius: 64
    
    color: backgroundColor

    MaterialSymbol {
        anchors.centerIn: parent
        iconSize: 18
        text: icon
        color: primaryColor
    }

    MouseArea {
        anchors.fill: parent
        height: 20
        width: 20
        onClicked: {
            if (root.onClicked) {
                root.onClicked()
            }
        }
    }
}