import Quickshell
import QtQuick

import qs.services

// Clock
Text {
    id: root

    color: Appearance.colBlue
    font: Appearance.defaultFont_bold
    text: japanDateFMT()

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            let fmt = japanDateFMT()
            if (fmt)
                root.text = fmt
        }
    }


    function japanDateFMT() {
        const days = ["日","月","火","水","木","金","土"]
        //Qt.formatDateTime(new Date(), "ddd, MMM dd - HH:mm:ss")
        const now = new Date()
        const formatted = 
            (now.getMonth() + 1) + "月" + now.getDate() + "日(" + days[now.getDay()] + ")"
            + " ～ "
            + now.getHours().toString().padStart(2,"0") + ":" +
            now.getMinutes().toString().padStart(2,"0") + ":" +
            now.getSeconds().toString().padStart(2,"0")
        return formatted
    }
}