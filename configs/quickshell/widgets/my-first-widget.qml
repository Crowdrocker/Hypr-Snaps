import QtQuick
import Quickshell

PanelWindow {
    id: myWidget

    width: 300
    height: 200

    Rectangle {
        anchors.fill: parent
        color: "#1a1b26"  // TokyoNight background
        border.color: "#8A2BE2"  // WehttamSnaps violet
        border.width: 2
        radius: 10

        Column {
            anchors.centerIn: parent
            spacing: 10

            Text {
                text: "Hello, WehttamSnaps!"
                color: "#00FFFF"  // Cyan
                font.pixelSize: 20
                font.bold: true
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Rectangle {
                width: 200
                height: 40
                color: "#8A2BE2"
                radius: 5

                Text {
                    text: "Click Me"
                    color: "white"
                    anchors.centerIn: parent
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        console.log("Button clicked!")
                    }
                }
            }
        }
    }
}
