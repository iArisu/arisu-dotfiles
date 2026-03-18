import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io

import qs.services

/**
PLEASE READ ME

This component is here to abstract the handling of keys that are typically
set as handlers in hyprland and received in Quickshell.

(*) pressed, released behave as usual
    - they are fired no matter what

(*) shortPressed, shortReleased behave as you would expect
(*) longPressed, longReleased behave as you would expect
    - fired when a key is long pressed / released after a long press

(*) holdDuration is at minimum of 100 ms

Note: since we can't accuratly foreshadow the future, shortPressed / longPressed are always 
fired <holdDuration> ms after the key was actually pressed.
*/
GlobalShortcut {
    id: root
    property int holdDuration: 100

    property bool isKeyPressed: false
    property bool isKeyLongPressed: false

    property Timer holdTimer: Timer {
        interval: Math.max(100, root.holdDuration)
        repeat: false
        running: false

        onTriggered: {
             if (root.isKeyPressed && !root.isKeyLongPressed) {
                root.isKeyLongPressed = true
                root.longPressed()
            } else {
                root.isKeyLongPressed = false
                root.shortPressed()
            }
        }
    }

    signal shortPressed()
    signal shortReleased()
    signal longPressed()
    signal longReleased()

    onPressed: {
        root.isKeyPressed = true
        holdTimer.running = true
    }

    onReleased: {
        const wasLong = /*just in case*/root.isKeyPressed && root.isKeyLongPressed
        
        holdTimer.running = false
        root.isKeyPressed = false
        root.isKeyLongPressed = false

        if (wasLong) {
            root.longReleased()
        } else {
            root.shortReleased()
        }
    }
}