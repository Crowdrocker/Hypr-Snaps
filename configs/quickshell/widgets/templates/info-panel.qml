import QtQuick
import Quickshell

Rectangle {
    id: infoPanel

    property string labelText: "Label"
    property string valueText: "Value"
    property string iconText: "󰍹"

    width: 200
    height: 60
    color: "#1a1b26"
    border.color: "#8A2BE2"
    border.width: 1
    radius: 8

    Row {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 15

        // Icon
        Text {
            text: iconText
            color: "#00FFFF"
            font.pixelSize: 24
            anchors.verticalCenter: parent.verticalCenter
        }

        // Info
        Column {
            anchors.verticalCenter: parent.verticalCenter
            spacing: 5

            Text {
                text: labelText
                color: "#7aa2f7"
                font.pixelSize: 12
            }

            Text {
                text: valueText
                color: "#c0caf5"
                font.pixelSize: 16
                font.bold: true
            }
        }
    }
}
