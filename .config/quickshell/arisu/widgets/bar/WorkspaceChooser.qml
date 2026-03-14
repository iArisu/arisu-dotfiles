import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs.visuals
import qs.utils

Item {
    id: root
    implicitHeight: wkRow.implicitHeight + 4
    implicitWidth: wkRow.implicitWidth + 4


    Rectangle {
        anchors.fill: parent
        radius: 16
        color: Appearance.colWorkspaceSwitcher_bg
    }

    // Sliding active indicator
    Rectangle {
        id: highlight
        width: 24
        height: 24
        radius: 64
        color: Appearance.colWorkspaceSwitcher_active_bg

        y: (parent.height - height) / 2
        x: ((GlobalState.wschooser_selected_ws - 1) % Config.wschooser_ws_per_page + 1) * 28 - 28 + 2 // padding, see Item implicitWidth+4


        Behavior on x {
            NumberAnimation {
                duration: 220
                easing.type: Easing.OutCubic
            }
        }
    }

    RowLayout {
        id: wkRow
        spacing: 4
        anchors.centerIn: parent //padding

        Repeater {
            model: Config.wschooser_ws_per_page


            Item {
                id: wsBox
                width: 24
                height: 24

                required property int index

                property bool active: GlobalState.wschooser_selected_ws === (index + 1)
                property bool longPress: GlobalState.key_workspaceNumberLongPress
                //property bool hovered: false

                Text {                    
                    anchors.centerIn: parent
                    text: wsBox.longPress ? ((GlobalState.wschooser_ws_page * Config.wschooser_ws_per_page) + index + 1) : ""
                    color: wsBox.active ? 
                        Appearance.colWorkspaceSwitcher_active_fg :
                        Appearance.colWorkspaceSwitcher_fg
                    font: Appearance.defaultFont_bold
                    opacity: wsBox.longPress ? 1 : 0

                    Behavior on opacity {
                        NumberAnimation {
                            duration: 200;
                            easing.type: Easing.InOutCubic
                        }
                    }
                }


                Rectangle {
                    id: dotCircle
                    width: 6
                    height: 6
                    radius: width / 2
                    anchors.centerIn: parent
                    color: wsBox.active ?
                        Appearance.colWorkspaceSwitcher_dot_active :
                        Appearance.colWorkspaceSwitcher_dot
                    opacity: wsBox.longPress ? 0 : 1

                    Behavior on opacity {
                        NumberAnimation {
                            duration: 200;
                            easing.type: Easing.InOutCubic
                        }
                    }
                }
                
                MouseArea {
                    anchors.fill: parent
                    //hoverEnabled: true
                    //onEntered: wsBox.hovered = true
                    //onExited: wsBox.hovered = false
                    onClicked: {
                        Hyprland.dispatch("workspace " + (index + 1))
                    }
                }
            }
        }
    }
}   