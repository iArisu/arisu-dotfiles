import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects
import Qt5Compat.GraphicalEffects
import Qt.labs.platform

import qs.services

ApplicationWindow {
    id: root

    property string wallpaperImageSource: ""
    
    visible: true
    width: 700
    height: 500
    leftPadding: 10
    rightPadding: 10
    topPadding: 10
    bottomPadding: 10
    //minimumWidth: 750
    //minimumHeight: 500
    title: "arisu-dotfiles Settings"
    color: Appearance.settings_background
    
    onClosing: Qt.quit()

    Process {
        id: zenityPickWP
        command: ["zenity", "--file-selection", "--title=\"Pick an image\"", "--file-filter=\"Images | *.png *.jpg *.jpeg *.bmp\""]
        running: false
        stdout: StdioCollector {
            id: outputCollector
        }
        onExited: {
            console.log("WP: ", outputCollector.text);
            const targetWP = outputCollector.text.trim();
            if (exitCode === 0) {
                root.wallpaperImageSource = targetWP;
                Quickshell.execDetached(["awww", "img", targetWP, "-t", "none"]);
            }
        }
    }

    Process {
        id: wallpaperLoader
        command: ["sh", "-c", "awww query -j | jq -r '.[\"\"][0].displaying.image'"]
        running: true
        stdout: StdioCollector {
            id: wpOC
            onStreamFinished: {
                console.log("WP: ", wpOC.text);
                root.wallpaperImageSource = wpOC.text.trim().replace("\n", "")
            }
        }
    }

        
    Rectangle {
        id: wpPreview
        radius: 64
        width: 192 * 2
        height: 108 * 2
        color: "transparent"

        property bool showWPPickOverlay: false
        Image {
            id: img
            anchors.fill: parent
            width: 192
            height: 108
            source: wallpaperImageSource
            fillMode: Image.PreserveAspectCrop
            visible: true
            layer.enabled: true
            layer.effect: OpacityMask {
                maskSource: Item {
                    width: img.width
                    height: img.height
                    Rectangle {
                        anchors.centerIn: parent
                        width: img.width
                        height: img.height
                        radius: 16
                    }
                }
            }
        }

        Rectangle {
            anchors.fill: parent
            color: '#000000'
            opacity: wpPreview.showWPPickOverlay ? 0.4 : 0
            radius: 16
            Behavior on opacity {
                NumberAnimation { duration: 200; easing.type: Easing.InOutQuad; }
            }
        }

        // Text shown on hover
        Text {
            anchors.centerIn: parent
            text: "Change"
            color: "white"
            font.bold: true
            font.pixelSize: 24
            opacity: wpPreview.showWPPickOverlay ? 1 : 0
            Behavior on opacity {
                NumberAnimation { duration: 200; easing.type: Easing.InOutQuad; }
            }
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true

            cursorShape: Qt.PointingHandCursor
            onEntered: wpPreview.showWPPickOverlay = true
            onExited: wpPreview.showWPPickOverlay = false
            onClicked: {
                if (!zenityPickWP.running)
                    zenityPickWP.running = true
            }
        }
    }

    /*Button {
        text: "Pick Wallpaper"
        anchors.centerIn: parent
        onClicked: {
            zenityPickWP.running = true
        }
    }*/
}