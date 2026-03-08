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

PanelWindow {
    id: root
    implicitHeight: 40
    aboveWindows: false
    anchors {
        top: true
        left: true
        right: true
    }
    
    margins {
        left: 10
        top: 10
        right: 10
        bottom: 0
    }

    ShellRoot {
        Overview {}
    }

    property color colBg: "#1a1b26"
    property color colFg: "#a9b1d6"
    property color colMuted: "#444b6a"
    property color colCyan: "#0db9d7"
    property color colBlue: "#7aa2f7"
    property color colYellow: "#e0af68"

    property int cpuUsage: 0
    property int memUsage: 0
    property var lastCpuIdle: 0
    property var lastCpuTotal: 0
    property int updateInterval: 2

    property int workspacesPerPage: 10
    property int selectedWorkspace: Hyprland.focusedWorkspace?.id ?? 1
    property int workspacePage: Math.trunc((selectedWorkspace - 1) / workspacesPerPage)


    
    readonly property Toplevel activeWindow: ToplevelManager.activeToplevel
    color: "transparent"

    Rectangle {
        anchors.centerIn: parent //padding
        anchors.fill: parent
        radius: 64         // Corner radius
        color: "#1a1b26"
        z: 1
    
        RowLayout {
            id: wkSelector
            anchors.centerIn: parent //padding
            anchors.fill: parent
            anchors.margins: 4
            spacing: 0

            Item {
                Layout.preferredWidth: 12
            }

            Column {
                spacing: -4
                //anchors.centerIn: parent
                Text {
                    text: StringTrim.ellipsis(root.activeWindow?.appId ?? "", 64)
                    color: "gray"
                    font.bold: true
                }

                Text {
                    text: StringTrim.ellipsis(root.activeWindow?.title ?? "", 70)
                    color: "white"
                    font.pixelSize: 14
                    verticalAlignment: Text.AlignTop
                }
            }

            WorkspaceChooser {
                anchors.centerIn: parent //padding
            }

            Item { Layout.fillWidth: true }

            // CPU Text
            Text {
                id: cpuText
                text: "CPU: " + Math.floor(ResourceUsage.cpuUsage * 100) + "%"
                color: root.colYellow
                font { family: Appearance.fontFamily; pixelSize: Appearance.fontSize; bold: true }
            }
            Item { Layout.preferredWidth: 10 }
            Rectangle { width: 1; height: 16; color: root.colMuted }
            Item { Layout.preferredWidth: 10 }

            // Memory Text
            Text {
                id: memText
                text: "Mem: " + Math.floor(ResourceUsage.memoryUsedPercentage * 100) + "%"
                color: root.colCyan
                font { family: Appearance.fontFamily; pixelSize: Appearance.fontSize; bold: true }
            }

            Item { Layout.preferredWidth: 10 }
            Rectangle { width: 1; height: 16; color: root.colMuted }
            Item { Layout.preferredWidth: 10 }


            JapaneseDate {}

            Item { Layout.preferredWidth: 10 }
            Rectangle { width: 1; height: 16; color: root.colMuted }
            Item { Layout.preferredWidth: 10 }

            PerformancePopup {}

            Rectangle {
                height: 24
                width: 24
                color: Appearance.colWorkspaceSwitcher_bg
                radius: 64

                MaterialSymbol {
                    anchors.centerIn: parent
                    iconSize: 18
                    text: "settings"
                    color: Appearance.colWorkspaceSwitcher_fg
                }

                MouseArea {
                    anchors.fill: parent
                    height: 20
                    width: 20
                    onClicked: {
                        console.log(Quickshell.shellPath("Settings.qml"))
                        Quickshell.execDetached(["qs", "-p", Quickshell.shellPath("Settings.qml")]);
                    }
                }
            }

            Item {
                Layout.preferredWidth: 6
            }
        }
    }

}
