import "./modules/external/overview/modules/overview"

import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs.widgets.bar
import qs.widgets
import qs.visuals
import qs.utils
import qs

ShellRoot {
    id: root
    Overview {}

    // to test
    /*Timer {
        id: resetCornersTimer
        interval: 2000
        running: true
        repeat: true
        onTriggered: GlobalState.topbar_detached = !GlobalState.topbar_detached
    }*/

    RoundedCorners {}
    TabBar {}
}