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
        left: 0
        top: 0
        right: 0
        bottom: 0
    }

    property bool detachedTopBar: false


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

    Item {
        anchors.fill: parent

        anchors.leftMargin: detachedTopBar ? 10 : 0
        anchors.topMargin: 0
        anchors.rightMargin: detachedTopBar ? 10 : 0
        anchors.bottomMargin: 0

        Rectangle {
            anchors.centerIn: parent //padding
            anchors.fill: parent
            radius: detachedTopBar ? 64 : 0         // Corner radius
            color: Appearance.topbar_bg
        }
        
        Item {
            anchors.fill: parent
            anchors.leftMargin: 10
            anchors.topMargin: 0
            anchors.rightMargin: 10
            anchors.bottomMargin: 0
            Rectangle {
                anchors.centerIn: parent //padding
                anchors.fill: parent
                color: "transparent"
                z: 1
            
                RowLayout {
                    id: wkSelector
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.margins: 4
                    height: parent.height
                    spacing: 0

                    Item { Layout.preferredWidth: 12 }
                    Item {
                        Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                        Layout.fillHeight: true

                        Column {
                            anchors.verticalCenter: parent.verticalCenter
                            height: parent.height
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
                    }
                }


                RowLayout {
                    anchors.centerIn: parent
                    spacing: 0
                    WorkspaceChooser {
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    }
                }

                RowLayout {
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    Layout.fillHeight: true
                    spacing: 0
                    
                    MetricsChip {
                        percentage: ResourceUsage.cpuUsage
                        icon: "earthquake"
                    }

                    Item { Layout.preferredWidth: 12 }

                    MetricsChip {
                        percentage: ResourceUsage.memoryUsedPercentage
                        icon: "memory"
                    }

                    Item { Layout.preferredWidth: 10 }
                    Rectangle { width: 1; height: 16; color: root.colMuted }
                    Item { Layout.preferredWidth: 10 }


                    JapaneseDate {}

                    Item { Layout.preferredWidth: 10 }
                    Rectangle { width: 1; height: 16; color: root.colMuted }
                    Item { Layout.preferredWidth: 10 }

                    PerformancePopup {}

                    Item { Layout.preferredWidth: 6 }
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

                    Item { Layout.preferredWidth: 8 }
                }
            }
        }
    }
}