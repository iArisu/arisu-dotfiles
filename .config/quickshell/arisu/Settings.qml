import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: mainWindow
    visible: true
    width: 1100
    height: 750
    minimumWidth: 750
    minimumHeight: 500
    title: "Arisu's Settings"
    color: "#FFF5F8" // soft pastel background
    // TODO
    onClosing: Qt.quit()
}