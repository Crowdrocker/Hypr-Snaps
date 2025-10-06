import QtQuick
import Quickshell

Rectangle {
    id: buttonWidget

    property string buttonText: "Button"
    property color buttonColor: "#8A2BE2"
    property color textColor: "#FFFFFF"
    signal clicked()

    width: 150
    height: 40
    color: buttonColor
    radius: 8

    Text {
        text: buttonWidget.buttonText
        color: buttonWidget.textColor
        font.pixelSize: 14
        font.bold: true
        anchors.centerIn: parent
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true

        onEntered: parent.color = Qt.lighter(buttonColor, 1.2)
        onExited: parent.color = buttonColor
        onClicked: buttonWidget.clicked()
    }
}
