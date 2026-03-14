import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls


import qs.services

Item {
    id: root

    property var windowByAddress: HyprlandData.windowByAddress

    property var iconsPaths: []

    function updateIcons() {
        const newIcons = [...iconsPaths]  // clone current array

        ToplevelManager.toplevels.values.forEach(tl => {
            if (!tl || !tl.appId || !tl.HyprlandToplevel.address) return;

            const address = `0x${tl.HyprlandToplevel.address}`
            const win = windowByAddress[address]
            const wid = win?.workspace?.id
            if (!wid) return

            const entry = DesktopEntries.heuristicLookup(tl.appId)
            const iconPath = Quickshell.iconPath(
                entry?.icon ?? "application-x-executable",
                "image-missing"
            )

            // Only update if changed
            if (newIcons[wid - 1] !== iconPath) {
                newIcons[wid - 1] = iconPath
                console.log(Date.now(), "Updating icon:", tl.appId, address, wid)
            }
        })

        // Apply only actual changes
        iconsPaths = [...newIcons];
    }
    
    Component.onCompleted: {
        updateIcons()
    }

    Connections {
        // Listen for changes to the top-level windows
        target: ToplevelManager.toplevels

        function onValuesChanged() {
            updateIcons()
        }
    }

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
                required property int index

                property string currentIcon: ""
                property bool active: GlobalState.wschooser_selected_ws === (index + 1)
                property bool longPress: GlobalState.key_workspaceNumberLongPress
                //property bool hovered: false

                Connections {
                    target: root
                    
                    function onIconsPathsChanged() {
                        const newIcon = root.iconsPaths[index] ?? ""
                        if (newIcon !== wsBox.currentIcon) {
                            wsBox.currentIcon = newIcon
                        }
                    }
                }

                Component.onCompleted: {
                    wsBox.currentIcon = root.iconsPaths[index] ?? ""
                }
                
                width: 24
                height: 24

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
                    visible: root.iconsPaths[index] == undefined

                    Behavior on opacity {
                        NumberAnimation {
                            duration: 200;
                            easing.type: Easing.InOutCubic
                        }
                    }
                }
                
                Item {
                    width: 24
                    height: 24
                    clip: false  // allow overflow

                    Rectangle {
                        width: 24
                        height: 24
                        radius: 64
                        visible: root.iconsPaths[index] != undefined
                        color: Appearance.colWorkspaceSwitcher_icon_bg

                        opacity: wsBox.longPress ? 1 : 0

                        y: wsBox.longPress ? 10 : 0
                        x: wsBox.longPress ? 10 : 0
                        scale: wsBox.longPress ? 0.8 : 1
                        
                        Behavior on scale {
                            NumberAnimation { duration: 200; easing.type: Easing.InOutCubic }
                        }

                        Behavior on x {
                            NumberAnimation { duration: 200; easing.type: Easing.InOutCubic }
                        }
            
                        Behavior on y {
                            NumberAnimation { duration: 200; easing.type: Easing.InOutCubic }
                        }

                        Behavior on opacity {
                            NumberAnimation { duration: 200; easing.type: Easing.InOutCubic }
                        }
                    }

                    Image {
                        anchors.margins: 1
                        height: 24
                        width: 24
                        visible: currentIcon != ""
                        source: currentIcon

                        y: wsBox.longPress ? 10 : 0
                        x: wsBox.longPress ? 10 : 0
                        scale: wsBox.longPress ? 0.75 : 1
                        
                        Behavior on scale {
                            NumberAnimation { duration: 200; easing.type: Easing.InOutCubic }
                        }

                        Behavior on x {
                            NumberAnimation { duration: 200; easing.type: Easing.InOutCubic }
                        }
            
                        Behavior on y {
                            NumberAnimation { duration: 200; easing.type: Easing.InOutCubic }
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