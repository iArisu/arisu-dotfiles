pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io


Singleton {
    id: root
    
    function nearQML(val, dec = 1) {
        const fac = 10**dec;
        return Math.round(val*fac)/fac;
    }
}
