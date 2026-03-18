pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io

import qs.modules.common.functions
import qs.services

Singleton {
    id: root
    
    
    property bool key_workspaceNumber: false
    property bool key_workspaceNumberLongPress: false

    

    property int wschooser_selected_ws: Hyprland.focusedWorkspace?.id ?? 1
    property int wschooser_ws_page: Math.trunc((root.wschooser_selected_ws - 1) / Config.wschooser_ws_per_page)


    AgedGlobalShortcut {
        name: "workspaceNumber"
        description: "Hold to show workspace numbers, release to show icons"
        holdDuration: 150

        onPressed: root.key_workspaceNumber = true;
        onLongPressed: root.key_workspaceNumberLongPress = true;

        onReleased: {
            root.key_workspaceNumber = false;
            root.key_workspaceNumberLongPress = false;
        }

        onShortReleased: Quickshell.execDetached(["sh", "-c", "pkill fuzzel || fuzzel"]);
    }
}