pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell

Singleton {
    id: root
    
    function ellipsis(str, max) {
        if (!str || String(str) !== str) return str;

        if (str.length > max) {
            return str.slice(0, max - 3) + "...";
        }
        return str;
    }
}
