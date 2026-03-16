import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Services.SystemTray

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls


import qs.modules.common.functions
import qs.modules.common.widgets
import qs.services

PanelWindow {
    id: root

    readonly property Toplevel activeWindow: ToplevelManager.activeToplevel
    property real targetY: Config.topbar_detached ? 10 : 0

    implicitHeight: 40
    aboveWindows: false

    anchors.top: true
    anchors.left: true
    anchors.right: true

    margins.top: Animations.nearQML(targetY)
    margins.left: 0
    margins.right: 0
    margins.bottom: 0

    color: "transparent"

    Behavior on targetY {
        NumberAnimation { duration: 50; easing.type: Easing.InOutQuad; }
    }


    Item {
        property real targetMargin: Config.topbar_detached ? 10 : 0

        anchors.fill: parent
        anchors.leftMargin: Animations.nearQML(targetMargin)
        anchors.rightMargin: Animations.nearQML(targetMargin)
        anchors.topMargin: 0
        anchors.bottomMargin: 0

        Behavior on targetMargin {
            NumberAnimation { duration: 300; easing.type: Easing.InOutQuad }
        }

        
        Rectangle {
            property real targetCornerRadius: Config.topbar_detached ? 64 : 0
            
            anchors.centerIn: parent //padding
            anchors.fill: parent

            radius: Animations.nearQML(targetCornerRadius)
            color: Appearance.topbar_bg

            Behavior on targetCornerRadius {
                NumberAnimation { duration: 300; easing.type: Easing.InOutQuad }
            }
        }
        
        Item {            
            anchors.fill: parent
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            anchors.topMargin: 0
            anchors.bottomMargin: 0

            Rectangle {
                anchors.fill: parent
                anchors.centerIn: parent //padding
                color: "transparent"
                z: 1
            
                RowLayout {
                    id: wkSelector
                    
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.margins: 4
                    
                    height: parent.height
                    spacing: 0

                    Item {
                        Layout.leftMargin: 16
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
                    id: rightBar
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    Layout.fillHeight: true
                    spacing: 12
                    
                    MetricsChip {
                        percentage: ResourceUsage.cpuUsage
                        icon: "earthquake"
                    }


                    MetricsChip {
                        percentage: ResourceUsage.memoryUsedPercentage
                        icon: "memory"
                    }

                    Rectangle { width: 1; height: 16; color: Appearance.colMuted }

                    Row {
                        spacing: 10
                        Repeater {
                            model: SystemTray.items

                            delegate: Item {
                                width: 24
                                height: 24
                                Image {
                                    anchors.fill: parent
                                    anchors.centerIn: parent

                                    source: modelData.icon
                                    sourceSize.width: width
                                    sourceSize.height: height
                                    
                                    cache: false // up to debate 
                                    visible: true
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        Qt.callLater(() => modelData.activate())
                                    }
                                }
                            }
                        }
                    }

                    Rectangle { width: 1; height: 16; color: Appearance.colMuted }

                    JapaneseDate {}

                    Rectangle { width: 1; height: 16; color: Appearance.colMuted }

                    /*PerformancePopup {
                        rootWindow: root
                    }*/

                    ButtonChip {
                        icon: "settings"
                        Layout.rightMargin: 12
                        onClicked: function onClicked() {
                            Quickshell.execDetached(["qs", "-p", Quickshell.shellPath("modules/settings/Settings.qml")]);
                        }
                    }
                }
            }
        }
    }
}