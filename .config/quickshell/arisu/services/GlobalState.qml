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


    AgedGlobalShortcut {
        name: "workspaceNumber"
        description: "Hold to show workspace numbers, release to show icons"
        holdDuration: 150 // allow slow pcs

        onPressed: {
            root.key_workspaceNumber = true;
        }

        onLongPressed: {
            root.key_workspaceNumberLongPress = true;
        }

        onReleased: {
            root.key_workspaceNumber = false;
            root.key_workspaceNumberLongPress = false;
        }
    }
}