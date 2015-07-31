import QtQuick 2.4

TimerSettingsForm {
    signal timeOut

    function timeSeconds() {
        var secondsInMinute = 60
        return value_minutes * secondsInMinute + value_seconds
    }

    function decrement() {
        if(value_seconds == 0) {
            if(value_minutes == 0) {
                return false
            } else {
                value_seconds = 59
                value_minutes--
            }
        } else {
            value_seconds--
        }
        return true
    }

    function isZero() {
        return value_minutes == 0 && value_seconds == 0;
    }

    function reset() {
        value_minutes = sliderMinutes.value
        value_seconds = sliderSeconds.value
    }
}

