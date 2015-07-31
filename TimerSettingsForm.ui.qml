import QtQuick 2.4
import QtQuick.Controls 1.2

Item {
    id: item1
    width: 250
    height: 160
//    anchors.horizontalCenter: parent.horizontalCenter

    property alias sliderMinutes : sliderMinutes
    property alias sliderSeconds : sliderSeconds
    property alias groupBox : groupBox
    property alias checkBoxVibrate : checkBoxVibrate
    property alias checkBoxSound : checkBoxSound

    property int value_minutes : 0
    property int value_seconds : 1

    GroupBox {
        id: groupBox
        clip: true
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.fill: parent
        title: qsTr("Таймер")

        Column {
            spacing: 5
            anchors.fill: parent

            Label {
                id: labelTime
//                text: qsTr("00:01")
                text: ((value_minutes < 10) ? "0" : "") + value_minutes + ":" +
                      ((value_seconds < 10) ? "0" : "") + value_seconds
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.right: parent.right
                anchors.rightMargin: 0
                font.pointSize: 17
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }

            Row {
                spacing: 30
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.right: parent.right

                CheckBox {
                    id: checkBoxVibrate
                    text: qsTr("Вібрація")
                    enabled: false
                    checked: false
                }

                CheckBox {
                    id: checkBoxSound
                    text: qsTr("Звук")
                    checked: true
                }
            }

            Grid {
                width: parent.width
                height: sliderMinutes.height + sliderSeconds.height + spacing
                spacing: 2
                columns: 2

                Label {
                    id: labelMinutes
                    text: qsTr("Хвилин: ")
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    height: sliderMinutes.height
                }

                Slider {
                    id: sliderMinutes
                    width: parent.width - labelMinutes.width - parent.spacing
                    stepSize: 1
                    minimumValue: 0
                    maximumValue: 59
                    onValueChanged: value_minutes = value
                }

                Label {
                    id: labelSeconds
                    text: qsTr("Секунд: ")
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    height: sliderSeconds.height
                }

                Slider {
                    id: sliderSeconds
                    width: sliderMinutes.width
                    stepSize: 1
                    minimumValue: (sliderMinutes.value == 0) ? 1 : 0
                    maximumValue: 59
                    onValueChanged: value_seconds = value
                }
            }
        }
    }

    states: [
        State {
            name: "Disabled"

            PropertyChanges {
                target: sliderSeconds
                enabled: false
            }

            PropertyChanges {
                target: sliderMinutes
                enabled: false
            }
        }
    ]
}

