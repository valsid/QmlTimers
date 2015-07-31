import QtQuick 2.4
import QtQuick.Controls 1.2

Rectangle {
    id: rectangle1
//    anchors.fill: parent
    width: 400
    height: 500

    property alias buttonInfo : buttonInfo
    property alias buttonStart : buttonStart
    property alias buttonStop  : buttonStop
    property alias buttonReset : buttonReset
    property alias buttonPause  : buttonPause
    property alias buttonResure : buttonResure
    property alias buttonAddTimer    : buttonAddTimer
    property alias buttonRemoveTimer : buttonRemoveTimer


    property alias scrollView : scrollView
    property alias timersContainer : timersContainer

    Row {
        id: rowAddRemove
        height: buttonAddTimer.height
//        width: parent.width
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 3
        Button {
            id: buttonAddTimer
            text: qsTr("Додати таймер")
//            anchors.right: parent.right
//            anchors.left: parent.horizontalCenter
            iconName: "list-add"
        }

        Button {
            id: buttonRemoveTimer
            text: qsTr("Видалити таймер")
            iconName: "list-remove"
        }
    }

    ScrollView {
        id: scrollView
        height: parent.height - row1.height - rowAddRemove.height
        width: parent.width
        frameVisible: true
        anchors.top: rowAddRemove.bottom
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        Column {
            id: timersContainer
            spacing: 10
            width: 250
            height: children.height

//            TimerSettings {x: (scrollView.width - width) / 2}
//            TimerSettings {x: (scrollView.width - width) / 2}
        }
    }

    property int spacing: 20
    Rectangle {
        id: row1
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: buttonStart.height + buttonPause.height + 4 + 5
        width: parent.width

        Button {
            id: buttonStart
            text: qsTr("Запустити")
            iconName: "media-playback-start"
            anchors.right: parent.right
            anchors.rightMargin: spacing
            anchors.left: parent.left
            anchors.leftMargin: spacing
        }

        Button {
            id: buttonStop
            text: qsTr("Зупинити")
            iconName: "media-playback-stop"
            anchors.top: buttonStart.top
            anchors.topMargin: buttonStart.anchors.topMargin
            anchors.right: buttonStart.right
//            anchors.rightMargin: buttonStart.anchors.rightMargin
            anchors.left: buttonStart.left
//            anchors.leftMargin: buttonStart.anchors.leftMargin
            visible: false
        }

        Button {
            id: buttonReset
            text: qsTr("Перезапустити")
            iconName: "view-refresh"
            anchors.right: buttonStart.right
//            anchors.rightMargin: buttonStart.anchors.rightMargin
            anchors.left: buttonStart.left
//            anchors.leftMargin: buttonStart.anchors.leftMargin
            visible: false
        }

        Button {
            id: buttonPause
            text: qsTr("Пауза")
            enabled: false
            iconName: "media-playback-pause"
            anchors.top: buttonStart.bottom
            anchors.topMargin: 4
            anchors.right: parent.right
            anchors.rightMargin: spacing
            anchors.left: parent.horizontalCenter
            anchors.leftMargin: spacing / 2
        }

        Button {
            id: buttonResure
            text: qsTr("Продовження")
            iconName: "media-playback-start"
            anchors.top: buttonPause.top
            anchors.right: buttonPause.right
//            anchors.rightMargin: buttonPause.anchors.rightMargin
            anchors.left: buttonPause.left
//            anchors.leftMargin: spacing / 2
            visible: false
        }

        Button {
            id: buttonInfo
            text: qsTr("Інфо")
            iconName: "dialog-information"
            anchors.top: buttonStart.bottom
            anchors.left: parent.left
            anchors.leftMargin: spacing
            anchors.topMargin: 4
            anchors.right: parent.horizontalCenter
            anchors.rightMargin: spacing / 2
        }
    }
    states: [
        State {
            name: "Run"

            PropertyChanges {
                target: buttonStart
                visible: false
            }

            PropertyChanges {
                target: buttonStop
                visible: true
            }

            PropertyChanges {
                target: buttonPause
                enabled: true
            }

            PropertyChanges {
                target: buttonResure
                visible: false
            }

            PropertyChanges {
                target: buttonAddTimer
                enabled: false
            }

            PropertyChanges {
                target: buttonRemoveTimer
                enabled: false
            }

//            PropertyChanges {
//                target: timerSettings1
//                state: "disabled"
//            }
        },
        State {
            name: "Pause"
            PropertyChanges {
                target: buttonStart
                visible: false
            }

            PropertyChanges {
                target: buttonStop
                visible: true
            }

            PropertyChanges {
                target: buttonPause
                visible: false
                enabled: true
            }

            PropertyChanges {
                target: buttonResure
                visible: true
            }

            PropertyChanges {
                target: buttonAddTimer
                enabled: false
            }

            PropertyChanges {
                target: buttonRemoveTimer
                enabled: false
            }
        },
        State {
            name: "End"

            PropertyChanges {
                target: buttonAddTimer
                enabled: false
            }

            PropertyChanges {
                target: buttonRemoveTimer
                enabled: false
            }

            PropertyChanges {
                target: buttonPause
                visible: false
            }

            PropertyChanges {
                target: buttonStart
                visible: false
            }

            PropertyChanges {
                target: buttonStop
                anchors.top: buttonStart.bottom
                anchors.topMargin: 4
                anchors.left: row1.horizontalCenter
                anchors.leftMargin: spacing / 2
                visible: true
            }

            PropertyChanges {
                target: buttonReset
                visible: true
            }
        }
    ]
}
