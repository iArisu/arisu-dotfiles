pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io


Singleton {
    id: root
    
    function nearQML(val) {
        return Math.round(val*10)/10;
    }
}
