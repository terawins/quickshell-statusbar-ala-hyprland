import Quickshell
import QtQuick
import Quickshell.Io
import Quickshell.Hyprland

PanelWindow {
    id: bar
    anchors {
        top: true
        left: true
        bottom: true
    }
    implicitWidth: 40
    color: "grey"

    // THE CLOCK
    Text {
        id: clock
        color: "white"
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 16
        font.bold: true
        topPadding: 10

        Process {
            id: dateProc
            command: ["date", "+%H%n%M"]
            running: true
            stdout: StdioCollector {
                onStreamFinished: clock.text = this.text.trim()
            }
        }

        Timer {
            interval: 1000
            running: true
            repeat: true
            onTriggered: dateProc.running = true
        }
    }

    // THE WORKSPACES
    Column {
        anchors {
            top: clock.bottom
            topMargin: 30
            horizontalCenter: parent.horizontalCenter
        }
        spacing: 12
        Repeater {
            model: Hyprland.workspaces.values
            Rectangle {
                width: 24
                height: 24
                radius: 6
                color: modelData.active ? "#1e1e2e" : "#cdd6f4"

                Text {
                    text: modelData.id
                    color: modelData.active ? "white" : "black"
                    anchors.centerIn: parent
                    font.pixelSize: 12
                    font.bold: true
                }
            }
        }
    }
}
