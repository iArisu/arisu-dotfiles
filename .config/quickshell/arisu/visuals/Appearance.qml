pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell


Singleton {
    readonly property color colWorkspaceSwitcher_fg: "#ffffff"
    readonly property color colWorkspaceSwitcher_active_fg: "#ffffff"
    readonly property color colWorkspaceSwitcher_bg: "#313d57"
    readonly property color colWorkspaceSwitcher_active_bg: "#4d659a"

    readonly property string fontFamily: "JetBrainsMono Nerd Font"
    readonly property int fontSize: 14
}