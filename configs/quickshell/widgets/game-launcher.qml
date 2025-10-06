import QtQuick
import Quickshell

PanelWindow {
    id: gameLauncher

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
                text: "Gaming"
                color: "#00FFFF"
                font.pixelSize: 18
                font.bold: true
            }

            Button {
                text: "Steam"
                onClicked: Qt.process.start("steam")
            }

            Button {
                text: "Lutris"
                onClicked: Qt.process.start("lutris")
            }

            Button {
                text: "Heroic"
                onClicked: Qt.process.start("heroic")
            }

            Button {
                text: "Discord"
                onClicked: Qt.process.start("discord")
            }

            Button {
                text: "Spotify"
                onClicked: Qt.process.start("spotify")
            }
        }
    }
}
