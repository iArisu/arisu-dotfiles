import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls


import qs.modules.common.widgets
import qs.services

Item {
    id: root

    property int _selected_ws: Hyprland.focusedWorkspace?.id ?? 1
    property int _workspace_page: Math.trunc(((Hyprland.focusedWorkspace?.id ?? 1) - 1) / Config.wschooser_ws_per_page)

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
        x: ((root._selected_ws - 1) % Config.wschooser_ws_per_page) * 28 + 2 // padding, see Item implicitWidth+4


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
                required property int index
                property int realIndex: index + root._workspace_page * Config.wschooser_ws_per_page
                
                property var biggestWindow: HyprlandData.biggestWindowForWorkspace(realIndex + 1)

                property bool active: root._selected_ws === (index + 1)
                property bool longPress: GlobalState.key_workspaceNumberLongPress
                
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
                

                Loader {
                    id: iconLoader
                    anchors.centerIn: parent

                    width: 20
                    height: 20
                    active: biggestWindow != null
                    sourceComponent: IconComponent {}
                }

                component IconComponent : Image {      
                    id: icon
                    width: 20
                    height: 20

                    sourceSize.width: width
                    sourceSize.height: height
                    
                    cache: false // up to debate 
                    visible: biggestWindow != null

                    source: Quickshell.iconPath(
                        DesktopEntries.byId(biggestWindow?.class)?.icon ?? "application-x-executable",
                        "image-missing"
                    )

                    y: wsBox.longPress ? 12 : parent.height / 2 - height / 2
                    x: wsBox.longPress ? 12 : parent.width / 2 - width / 2
                    scale: wsBox.longPress ? 0.85 : 1
                    
                    Behavior on x { SmoothAnim {} }
                    Behavior on y { SmoothAnim {} }
                    Behavior on scale { SmoothAnim {} }

                    layer.enabled: true
                    layer.effect: ColorTintEffect {
                        tint: Appearance.colWorkspaceSwitcher_icon_tint
                        apply: !wsBox.longPress
                        enabled_force: 1
                        disabled_force: 0.8
                    }

                    property bool _hovered: false
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: _hovered = true
                        onExited: _hovered = false
                    }
                    
                    /*Item {
                        y: 100
                        z: 10
                        parent: null
                        ToolTip {
                            visible: true
                            text: `Heyy`
                        }
                    }*/
                }
                
                MouseArea {
                    anchors.fill: parent
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