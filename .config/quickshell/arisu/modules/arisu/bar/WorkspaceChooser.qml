import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import QtQuick.Controls


import qs.services

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
        x: ((GlobalState.wschooser_selected_ws - 1) % Config.wschooser_ws_per_page) * 28 + 2 // padding, see Item implicitWidth+4


        Behavior on x {
            NumberAnimation {
                duration: 220
                easing.type: Easing.OutCubic
            }
        }
    }

    component SmoothAnim: NumberAnimation {
        duration: 200;
        easing.type: Easing.InOutCubic
    }

    
    RowLayout {
        id: wkRow
        spacing: 4
        anchors.centerIn: parent //padding

        Repeater {
            model: Config.wschooser_ws_per_page

            Item {
                id: wsBox
                required property var model
                property int index: model.index
                property int realIndex: index + GlobalState.wschooser_ws_page * Config.wschooser_ws_per_page
                
                property var biggestWindow: HyprlandData.biggestWindowForWorkspace(realIndex + 1)

                property bool active: GlobalState.wschooser_selected_ws === (index + 1)
                property bool longPress: GlobalState.key_workspaceNumberLongPress
                //property bool hovered: false
                
                width: 24
                height: 24

                Text {                    
                    anchors.centerIn: parent
                    text: realIndex + 1
                    color: wsBox.active ? 
                        Appearance.colWorkspaceSwitcher_active_fg :
                        Appearance.colWorkspaceSwitcher_fg
                    font: Appearance.defaultFont_bold
                    opacity: wsBox.longPress ? 1 : 0

                    Behavior on opacity { SmoothAnim {} }
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
                    visible: biggestWindow == null

                    Behavior on opacity { SmoothAnim {} }
                }
                
                
                
                Item {
                    width: 24
                    height: 24
                    clip: false  // allow overflow
                    visible: biggestWindow != null

                    /*Rectangle {
                        width: 26
                        height: 26
                        radius: 64
                        color: Appearance.colWorkspaceSwitcher_active_bg

                        opacity: wsBox.longPress ? 1 : 0

                        y: wsBox.longPress ? 9 : 0
                        x: wsBox.longPress ? 9 : 0
                        scale: wsBox.longPress ? 0.7 : 1
                        
                        Behavior on scale { SmoothAnim {} }
                        Behavior on x { SmoothAnim {} }
                        Behavior on y { SmoothAnim {} }
                        Behavior on opacity { SmoothAnim {} }
                    }*/

                    Image {
                        id: icon
                        height: 20
                        width: 20
                        visible: false // multi effect
                        source: Quickshell.iconPath(
                            DesktopEntries.byId(biggestWindow?.class)?.icon ?? "application-x-executable",
                            "image-missing"
                        )

                        y: wsBox.longPress ? 12 : parent.height / 2 - height / 2
                        x: wsBox.longPress ? 12 : parent.width / 2 - width / 2

                        Behavior on x { SmoothAnim {} }
                        Behavior on y { SmoothAnim {} }
                    }

                    MultiEffect {
                        anchors.fill: icon
                        source: icon

                        colorization: wsBox.longPress ? 0.5 : 1.0
                        colorizationColor: Appearance.colWorkspaceSwitcher_icon_tint
                        scale: wsBox.longPress ? 0.85 : 1
                        
                        Behavior on colorization { SmoothAnim {} }
                        Behavior on scale { SmoothAnim {} }
                    }
                }
                
                MouseArea {
                    anchors.fill: parent
                    //hoverEnabled: true
                    //onEntered: wsBox.hovered = true
                    //onExited: wsBox.hovered = false
                    onClicked: {
                        if (Hyprland.focusedWorkspace?.id != realIndex + 1) {
                            Hyprland.dispatch("workspace " + (realIndex + 1))
                        }
                    }
                }
            }
        }
    }
}   