import QtQuick
import Quickshell

Rectangle {
    id: launcherGrid

    property var apps: []  // Array of {name, icon, command}
    property int columns: 3

    width: (columns * 80) + ((columns + 1) * 10)
    height: Math.ceil(apps.length / columns) * 90 + 20
    color: "#1a1b26"
    border.color: "#8A2BE2"
    border.width: 2
    radius: 10

    Grid {
        anchors.centerIn: parent
        columns: launcherGrid.columns
        spacing: 10

        Repeater {
            model: apps

            Rectangle {
                width: 80
                height: 80
                color: "#16161e"
                radius: 8
                border.color: "#8A2BE2"
                border.width: 1

                Column {
                    anchors.centerIn: parent
                    spacing: 5

                    Text {
                        text: modelData.icon
                        color: "#00FFFF"
                        font.pixelSize: 32
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Text {
                        text: modelData.name
                        color: "#c0caf5"
                        font.pixelSize: 10
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true

                    onEntered: parent.border.color = "#00FFFF"
                    onExited: parent.border.color = "#8A2BE2"
                    onClicked: Qt.process.start(modelData.command)
                }
            }
        }
    }
}
