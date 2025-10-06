import QtQuick
import Quickshell
import Quickshell.Wayland

PanelWindow {
    id: topBar

    anchors {
        left: true
        right: true
        top: true
    }

    height: 40

    Rectangle {
        anchors.fill: parent
        color: "#1a1b26"
        opacity: 0.95

        Row {
            anchors.fill: parent
            anchors.margins: 5

            // Left side - Workspace indicator
            Rectangle {
                width: 200
                height: parent.height
                color: "transparent"

                Row {
                    anchors.centerIn: parent
                    spacing: 5

                    Repeater {
                        model: 9

                        Rectangle {
                            width: 20
                            height: 20
                            radius: 10
                            color: index === 0 ? "#8A2BE2" : "#16161e"
                            border.color: "#00FFFF"
                            border.width: 1

                            Text {
                                text: index + 1
                                color: "#c0caf5"
                                font.pixelSize: 10
                                anchors.centerIn: parent
                            }
                        }
                    }
                }
            }

            // Center - Title / J.A.R.V.I.S. status
            Item {
                width: parent.width - 400
                height: parent.height

                Text {
                    text: "WehttamSnaps Workstation"
                    color: "#00FFFF"
                    font.pixelSize: 14
                    font.bold: true
                    anchors.centerIn: parent
                }
            }

            // Right side - System info
            Rectangle {
                width: 200
                height: parent.height
                color: "transparent"

                Row {
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 15

                    // CPU indicator
                    Text {
                        text: " 45%"
                        color: "#c0caf5"
                        font.pixelSize: 12
                    }

                    // RAM indicator
                    Text {
                        text: "󰍛 8.2G"
                        color: "#c0caf5"
                        font.pixelSize: 12
                    }

                    // Time
                    Text {
                        id: timeText
                        text: Qt.formatTime(new Date(), "hh:mm")
                        color: "#c0caf5"
                        font.pixelSize: 12

                        Timer {
                            interval: 1000
                            running: true
                            repeat: true
                            onTriggered: timeText.text = Qt.formatTime(new Date(), "hh:mm")
                        }
                    }
                }
            }
        }
    }
}
