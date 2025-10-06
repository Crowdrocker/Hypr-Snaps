// File: ~/.config/quickshell/widgets/jarvis-status.qml
import QtQuick
import Quickshell

PanelWindow {
    id: jarvisStatus

    width: 300
    height: 150
    x: 810
    y: 50

    Rectangle {
        anchors.fill: parent
        color: "#1a1b26"
        border.color: "#8A2BE2"
        border.width: 2
        radius: 12

        // Animated gradient background
        Rectangle {
            anchors.fill: parent
            anchors.margins: 2
            radius: 10
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#8A2BE2" }
                GradientStop { position: 1.0; color: "#00FFFF" }
            }
            opacity: 0.1

            SequentialAnimation on opacity {
                loops: Animation.Infinite
                NumberAnimation { to: 0.3; duration: 2000 }
                NumberAnimation { to: 0.1; duration: 2000 }
            }
        }

        Column {
            anchors.centerIn: parent
            spacing: 15

            // J.A.R.V.I.S. logo
            Text {
                text: "🤖"
                font.pixelSize: 48
                anchors.horizontalCenter: parent.horizontalCenter
            }

            // Status text
            Text {
                text: "J.A.R.V.I.S."
                color: "#00FFFF"
                font.pixelSize: 24
                font.bold: true
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                id: statusText
                text: "All systems operational"
                color: "#7aa2f7"
                font.pixelSize: 12
                anchors.horizontalCenter: parent.horizontalCenter

                Timer {
                    interval: 5000
                    running: true
                    repeat: true
                    onTriggered: {
                        var messages = [
                            "All systems operational",
                            "Ready for gaming",
                            "Monitoring performance",
                            "Standing by"
                        ]
                        statusText.text = messages[Math.floor(Math.random() * messages.length)]
                    }
                }
            }
        }
    }
}
