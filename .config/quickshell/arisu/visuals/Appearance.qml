pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell


Singleton {
    readonly property color computer_metrics_fg: '#000000'
    readonly property color computer_metrics_bg: '#455983'
    readonly property color computer_metrics_fill: '#a6bef1'
    readonly property color computer_metrics_text: '#e1eaff'
    
    readonly property color colWorkspaceSwitcher_fg: "#ffffff"
    readonly property color colWorkspaceSwitcher_active_fg: "#ffffff"
    readonly property color colWorkspaceSwitcher_bg: "#313d57"
    readonly property color colWorkspaceSwitcher_active_bg: "#4d659a"

    readonly property color topbar_bg: "#1a1b26"

    readonly property string fontFamily: "JetBrainsMono Nerd Font"
    readonly property int fontSize: 14
}