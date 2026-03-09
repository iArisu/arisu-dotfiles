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
    Overview {}

    property bool with_detachedTopBar: false

    Loader {
        active: !with_detachedTopBar
        source: "RoundedCorners.qml"
    }


    TabBar {
        detachedTopBar: with_detachedTopBar
    }
}