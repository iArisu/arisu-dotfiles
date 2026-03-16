import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import qs.services

ApplicationWindow {
    id: root
    
    visible: true
    width: 1100
    height: 750
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
            onStreamFinished: {
                console.log("WP: ", outputCollector.text);
                Quickshell.execDetached(["awww", "img", outputCollector.text.trim(), "-t", "none"]);
            }
        }
    }
    
    Button {
        text: "Pick Wallpaper"
        anchors.centerIn: parent
        onClicked: {
            zenityPickWP.running = true
        }
    }
}