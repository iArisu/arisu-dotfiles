import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs.widgets
import qs.visuals

RowLayout {
    id: root

    readonly property color primaryColor: Appearance.computer_metrics_text
    readonly property color secondaryColor: Appearance.computer_metrics_fg
    readonly property color backgroundColor: Appearance.computer_metrics_bg

    required property real percentage
    required property string icon

    spacing: 5

    Rectangle {
        id: metrics_chip
        height: 24
        width: 24
        radius: 64

        color: backgroundColor

        Item {
            width: metrics_chip.width
            height: metrics_chip.height

            Canvas {
                id: canvas
                anchors.fill: parent

                onPaint: {
                    var ctx = getContext("2d")
                    ctx.reset()
                    ctx.clearRect(0, 0, width, height)

                    const radius = metrics_chip.width / 2
                    const centerX = radius //metrics_chip.width / 2
                    const centerY = radius //metrics_chip.height / 2
                    

                    const startAngle = -Math.PI / 2
                    const endAngle = startAngle + (root.percentage) * 2 * Math.PI // clockwise

                    // Draw background circle
                    /*ctx.beginPath()
                    ctx.arc(centerX, centerY, radius, 0, 2 * Math.PI, false)
                    ctx.fillStyle = '#eee'
                    ctx.fill()*/

                    ctx.beginPath()
                    ctx.arc(centerX, centerY, radius, startAngle, endAngle, false)
                    ctx.fillStyle = Appearance.computer_metrics_fill
                    ctx.lineTo(centerX, centerY)
                    ctx.fill()
                }
            }
        }
        MaterialSymbol {
            anchors.centerIn: parent
            iconSize: 18
            text: root.icon
            color: secondaryColor
        }
    }

    Text {
        id: metrics_chip_text
        text: String(Math.floor(root.percentage * 100)).padEnd(2, " ")
        color: primaryColor
        font: Appearance.defaultFont_bold
    }

    onPercentageChanged: canvas.requestPaint()
}