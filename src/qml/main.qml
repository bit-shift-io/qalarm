import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.4
import QtQuick.Layouts 1.11
import QtQuick.Window 2.11
import Qt.labs.calendar 1.0
import Qt.labs.settings 1.0
import Qt.labs.platform 1.1 // sys tray
import TimeService 1.0
import QtMultimedia 5.13


ApplicationWindow {
    
    id: window
    width: 350
    height: 500
    visible: true

    Audio {
        id: audio_alarm
        source: "alarm_analog_watch.ogg"
    }

    TimeService {
        // this ticks over on the minute
        // so is more accurate than a qml timer
        id: time_service
        onTimeChanged: {
            // check for alarm change here
            var params = {
                hour: time_service.hour,
                minute: time_service.minute,
            }
            var alarms = alarm_list_view.model.get_active_alarms(params)
            console.log(alarms.length)
            for (var i = 0; i < alarms.length; ++i) {
                // TODO: trigger alarm
                console.log("ALARM! " + time_service.hour + ":" + time_service.minute)
                system_tray.showMessage("Alarm", "Beep beep!")
                audio_alarm.play()
            }
        }
    }
    

    Connections {
        target: Qt.application
        onStateChanged: window_state_change()
    }

    Settings {
        // window settings
        category: "window"
        property alias x: window.x
        property alias y: window.y
        property alias width: window.width
        property alias height: window.height
    }

    ScrollView {
        id: scroll_view
        anchors.fill: parent

        // alarm list
        ListView {
            id: alarm_list_view
            anchors.fill: parent
            model: AlarmModel {}
            delegate: AlarmDelegate {
                // pass the alarm model into the delegate
                // so all our util functions are in the model
                property variant alarm_model: alarm_list_view.model
            }
        }

    }

    // add alarm button
    RoundButton {
        id: addAlarmButton
        text: "+"
        anchors.bottom: scroll_view.bottom
        anchors.bottomMargin: 8
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: alarm_dialog.open()
    }

    // dialog
    AlarmDialog {
        id: alarm_dialog
        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 2)
        alarm_model: alarm_list_view.model
    }


    
    // system tray
    SystemTrayIcon {
        id: system_tray
        visible: true
        icon.source: "qrc:/res/bitshift.alarm.png"

        /*
        menu: Menu {
            MenuItem {
                text: qsTr("Quit")
                onTriggered: Qt.quit()
            }
        }*/

        onMessageClicked: console.log("Message clicked")
        
        onActivated: {
            if (window.visible) {
                window.hide()
            } else {
                window.show()
                window.raise()
                window.requestActivate()
            }
        }
    }


    function window_state_change()
    {
        if (Qt.application.state == 2) { // minimized
            window.hide()
        }
    }
}
