import Quickshell
import QtQuick

import qs.visuals

// Clock
Text {
    id: clock
    color: root.colBlue
    font { family: Appearance.fontFamily; pixelSize: Appearance.fontSize; bold: true }
    text: japanDateFMT(clock)
    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: clock.text = japanDateFMT(clock)
    }


    function japanDateFMT(what) {
        const days = ["日","月","火","水","木","金","土"]
        //Qt.formatDateTime(new Date(), "ddd, MMM dd - HH:mm:ss")
        const now = new Date()
        const formatted = 
            (now.getMonth() + 1) + "月" + now.getDate() + "日(" + days[now.getDay()] + ")"
            + " - "
            + now.getHours().toString().padStart(2,"0") + ":" +
            now.getMinutes().toString().padStart(2,"0") + ":" +
            now.getSeconds().toString().padStart(2,"0")
        what.text = formatted
    }
}