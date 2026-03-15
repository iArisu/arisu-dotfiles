import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import QtQuick.Controls


import qs.services
import qs.modules.arisu.bar
import qs.modules.external.overview.modules.overview

ShellRoot {
    id: root
    Overview {}

    // to test
    /*Timer {
        id: resetCornersTimer
        interval: 2000
        running: true
        repeat: true
        onTriggered: Config.topbar_detached = !Config.topbar_detached
    }*/

    RoundedCorners {}
    Bar {}
}