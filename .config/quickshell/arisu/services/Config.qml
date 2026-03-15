pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io


Singleton {
    id: root
    
    property bool topbar_detached: false
    property int wschooser_ws_per_page: 10
}
