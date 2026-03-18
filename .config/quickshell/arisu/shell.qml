import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import QtQuick.Controls


import qs.modules.settings // See rules.conf

// TODO: get rid of Overview module?
import qs.modules.external.overview.modules.overview

import qs.modules.arisu.bar
import qs.services


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

    //Settings {} // See rules.conf
}