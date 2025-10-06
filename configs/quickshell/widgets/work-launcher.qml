import QtQuick
import Quickshell

PanelWindow {
    id: workLauncher

    width: 200
    height: 300

    Rectangle {
        anchors.fill: parent
        color: "#1a1b26"
        border.color: "#8A2BE2"
        border.width: 2
        radius: 10

        Column {
            anchors.centerIn: parent
            spacing: 10

            Text {
                text: "Work Tools"
                color: "#00FFFF"
                font.pixelSize: 18
                font.bold: true
            }

            Button {
                text: "GIMP"
                onClicked: Qt.process.start("gimp")
            }

            Button {
                text: "Inkscape"
                onClicked: Qt.process.start("inkscape")
            }

            Button {
                text: "Krita"
                onClicked: Qt.process.start("krita")
            }

            Button {
                text: "Blender"
                onClicked: Qt.process.start("blender")
            }

            Button {
                text: "Discord"
                onClicked: Qt.process.start("discord")
            }
        }
    }
}
