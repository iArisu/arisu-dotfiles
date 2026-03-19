import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick

import qs.modules.common.functions
import qs.services


Column {
    id: root
    readonly property var _focusedWorkspace: Hyprland.focusedWorkspace?.id
    readonly property var _activeWindow: _focusedWorkspace ? (
        HyprlandData.activeWindowForWorkspaceOrBiggest(_focusedWorkspace) ?? _emptyWorkspaceWindow
    ) : _emptyWorkspaceWindow

    readonly property var _emptyWorkspaceWindow: {
        "class": `༼ つ ╹ ╹ ༽つ  ${_focusedWorkspace}`,
        "title": ""
    }

    anchors.verticalCenter: parent.verticalCenter
    height: parent.height
    spacing: -4
    //anchors.centerIn: parent
    Text {
        text: StringTrim.ellipsis(root._activeWindow?.class ?? " ", 64)
        color: "gray"
        font.bold: true
    }

    Text {
        text: StringTrim.ellipsis(root._activeWindow?.title ?? " ", 70)
        color: "white"
        font.pixelSize: 14
        verticalAlignment: Text.AlignTop
    }
}