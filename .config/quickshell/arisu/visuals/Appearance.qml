pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell


Singleton {
    readonly property color computer_metrics_fg: '#000000'
    readonly property color computer_metrics_bg: '#455983'
    readonly property color computer_metrics_fill: '#a6bef1'
    readonly property color computer_metrics_text: '#e1eaff'
    
    readonly property color colWorkspaceSwitcher_dot: '#7c96ce'
    readonly property color colWorkspaceSwitcher_dot_active: '#e1eaff'
    readonly property color colWorkspaceSwitcher_fg: "#7c96ce"
    readonly property color colWorkspaceSwitcher_active_fg: "#ffffff"
    readonly property color colWorkspaceSwitcher_bg: "#313d57"
    readonly property color colWorkspaceSwitcher_active_bg: "#4d659a"

    readonly property color topbar_bg: "#1a1b26"

    readonly property string fontFamily: "JetBrainsMono Nerd Font"
    readonly property int fontSize: 14
    property font defaultFont: Qt.font({
        family: Appearance.fontFamily,
        pixelSize: Appearance.fontSize,
        bold: false
    })

    property font defaultFont_bold: Qt.font({
        family: Appearance.fontFamily,
        pixelSize: Appearance.fontSize,
        bold: true
    })


    readonly property color colBg: "#1a1b26"
    readonly property color colFg: "#a9b1d6"
    readonly property color colMuted: "#444b6a"
    readonly property color colCyan: "#0db9d7"
    readonly property color colBlue: "#7aa2f7"
    readonly property color colYellow: "#e0af68"
}