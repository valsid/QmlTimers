import QtQuick 2.4
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtMultimedia 5.0

Window {
    id: window1
    visible: true
    width: 400
    height: 500
    color: "white"

    property variant timersArray: []
    property variant timersArrayClock: []

    property var timerSettingsComponent : null

    property int nextTimerIndex: 1

    SoundEffect {
        id: playSound
        source: "timerSignal.wav"
    }

    function addTimer(minutes, seconds) {
        if(minutes == undefined) minutes = 0
        if(seconds == undefined) seconds = (minutes == 0 ? 1 : 0)

        timerSettingsComponent = Qt.createComponent("TimerSettings.qml")
        if(timerSettingsComponent.status == Component.Ready) {
            var obj = timerSettingsComponent.createObject(mainForm.timersContainer);

            obj.x = Qt.binding( function() {
                var dif = mainForm.scrollView.width - obj.width
                return dif < 0 ? 0 : dif / 2
            })
            obj.sliderMinutes.value = minutes
            obj.sliderSeconds.value = seconds
            obj.groupBox.title = qsTr("Таймер " + ((nextTimerIndex > 0) ? (nextTimerIndex++).toString() : ""))

            mainForm.buttonStart.clicked.connect(function() {obj.state = "Disabled"})
            mainForm.buttonStop .clicked.connect(function() {obj.state = ""})

            if(obj != null) {
                timersArray.push(obj)
            } else {
                console.log("Object not created. ")
            }
        } else {
            console.log("Main form component not ready.")
        }
    }

    function removeLastTimer() {
        if(timersArray.length != 0) {
            timersArray.pop().destroy()
        }
    }

    MessageDialog {
        id: messageDialog
        title: "Інформація"
        text: "Створив <a href=\"https://vk.com/id29498998\">Владислав Волівецький</a>. <br>Відгуки та ідеї приймаються ; )"
        detailedText: "Можливо, тут з’явиться: \n - Введення часу тумблером (як на циліндричному кодовому замку)\n - Видалення конкретних таймерів\ - Переміщення по списку до наступного таймеру у якого вийде час\n - Поступове видалення таймерів по мірі іх виконання (і відновлення після виконання всіх)\n - вимкнення та увімкнення конкретних таймерів\n - збереженя таймерів між запусками програми\n - прапорець автоперезапуску таймерів\n - автоперезапуск таймерів."
    }

    Timer {
        id: clockTimer
        interval: 1000
        repeat: true
        onTriggered: {
            timersArrayClock.forEach(function(currentValue, index, array) {
                currentValue.decrement()
            })

            var soundBePlayed = false;
            while(timersArrayClock.length != 0 && timersArrayClock[0].isZero()) {
//                if(timersArrayClock[0].checkBoxVibrate.checked) {
//                }
                if(timersArrayClock[0].checkBoxSound.checked) {
                    if(!soundBePlayed) {
                        playSound.stop()
                        playSound.play()
                        soundBePlayed = true
                    }
                }

                timersArrayClock.shift()
            }

            if(timersArrayClock.length == 0) {
                this.stop();
                mainForm.state = "End"
                if(false) { // TODO: repeat check box
                    mainForm.buttonReset.clicked()
                }
            }
        }
    }

    MainForm {
        id: mainForm
        anchors.fill: parent
        buttonStart.onClicked: {
            state = "Run"
            timersArray.sort( function(a, b){return a.timeSeconds() - b.timeSeconds()})
            timersArrayClock = timersArray.slice()
            clockTimer.start()
        }
        buttonStop.onClicked: {
            state = ""
            clockTimer.stop()
            timersArray.forEach(function(currentValue) {currentValue.reset()})
        }
        buttonReset.onClicked: {
            state = "Run"
            timersArray.forEach(function(currentValue) {currentValue.reset()})
            timersArrayClock = timersArray.slice()
            clockTimer.start()
        }
        buttonPause.onClicked: {
            state = "Pause"
            clockTimer.stop()
        }
        buttonResure.onClicked: {
            state = "Run"
            clockTimer.start()
        }
        buttonInfo.onClicked: {
            messageDialog.visible = true
        }
        buttonAddTimer.onClicked: {
            addTimer()
        }
        buttonRemoveTimer.onClicked: {
            removeLastTimer()
        }

        Component.onCompleted: {
            addTimer(3, 30)
            addTimer(5, 00)
        }
    }
}
