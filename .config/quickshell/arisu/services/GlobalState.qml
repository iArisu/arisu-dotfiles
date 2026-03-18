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
    
    
    // TODO: fix conflict with MOD+Q (close) and other MOD+... binds
    property bool key_workspaceNumber: false
    property int key_workspaceNumber_pressstartwk: -1
    property bool key_workspaceNumberLongPress: false

    

    property int wschooser_selected_ws: Hyprland.focusedWorkspace?.id ?? 1
    property int wschooser_ws_page: Math.trunc((root.wschooser_selected_ws - 1) / Config.wschooser_ws_per_page)


    AgedGlobalShortcut {
        name: "workspaceNumber"
        description: "Hold to show workspace numbers, release to show icons"
        holdDuration: 200 // allow slow pcs

        onPressed: {
            root.key_workspaceNumber = true;
            root.key_workspaceNumber_pressstartwk = Hyprland.focusedWorkspace?.id;
        }
        onLongPressed: {
            root.key_workspaceNumberLongPress = true;
        }

        onReleased: {
            root.key_workspaceNumber = false;
            root.key_workspaceNumberLongPress = false;
        }

        onShortReleased: {
            // don't show if it was a ninja-grade workspace switch
            if (root.key_workspaceNumber_pressstartwk == Hyprland.focusedWorkspace?.id) {
                Quickshell.execDetached(["sh", "-c", "pkill fuzzel || fuzzel"]);
            }
        }
    }
}