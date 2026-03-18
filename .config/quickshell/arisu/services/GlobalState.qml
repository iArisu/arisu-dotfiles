pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io

import qs.services

Singleton {
    id: root
    
    
    property bool key_workspaceNumber: false
    property bool key_workspaceNumberLongPress: false

    
    
    property int wschooser_selected_ws: Hyprland.focusedWorkspace?.id ?? 1
    property int wschooser_ws_page: Math.trunc((root.wschooser_selected_ws - 1) / Config.wschooser_ws_per_page)


    Timer {
        id: holdTimer
        interval: 150
        running: false
        repeat: false
        onTriggered: {
            if (root.key_workspaceNumber) {
                root.key_workspaceNumberLongPress = true
            } else {
                root.key_workspaceNumberLongPress = false
            }
        }
    }


    GlobalShortcut {
        name: "workspaceNumber"
        description: "Hold to show workspace numbers, release to show icons"

        onPressed: {
            root.key_workspaceNumber = true
            holdTimer.running = true
        }

        onReleased: {
            const openFuzzel = root.key_workspaceNumber && !root.key_workspaceNumberLongPress;
            
            holdTimer.running = false
            root.key_workspaceNumber = false
            root.key_workspaceNumberLongPress = false

            if (openFuzzel) {
                Quickshell.execDetached(["sh", "-c", "pkill fuzzel || fuzzel"]);
            }
        }
    }
}