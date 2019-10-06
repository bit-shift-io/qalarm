import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.11
import QtQuick.Window 2.11
import Style 1.0

Dialog {
    id: alarm_dialog
    //title: "Add alarm"
    modal: true
    standardButtons: DialogButtonBox.Ok | DialogButtonBox.Cancel

    property AlarmModel alarm_model
    property int alarm_index: -1

    function set_alarm_index(index) {
        alarm_index = index
        var alarm = alarm_model.get_alarm(index)
        hour_tumbler.currentIndex = alarm.hour - 1
        minute_tumbler.currentIndex = alarm.minute
    }

    onAccepted: {
        // get am/pm and adjust hours to suit
        var hours = hour_tumbler.currentIndex + 1
        if (am_pm_tumbler.state == "PM") {
            hours += 12
        }
        
        var params = {
            "hour": hours,
            "minute": minute_tumbler.currentIndex,
            "active": true,
            "label": "",
            "repeat": false,
            "repeat_list": [
                { "day_of_week": 1, "repeat": false },
                { "day_of_week": 2, "repeat": false },
                { "day_of_week": 3, "repeat": false },
                { "day_of_week": 4, "repeat": false },
                { "day_of_week": 5, "repeat": false },
                { "day_of_week": 6, "repeat": false }, // sat
                { "day_of_week": 0, "repeat": false }, // sun
            ],
        }

        if (alarm_index == -1) {
            // new alarm
            alarm_model.add_alarm(params)
        } else {
            // modify alarm
            alarm_model.set_alarm(alarm_index, params)
        }
    }

    onRejected: alarm_dialog.close()

    onOpened: {
        update_time_label()
    }

    function update_time_label() {
        time_label.text = alarm_model.get_display_time(hour_tumbler.currentIndex + 1, minute_tumbler.currentIndex) + am_pm_tumbler.state
    }

    contentItem: ColumnLayout {
        // time label
        RowLayout {
            id: time_layout
            Layout.fillWidth: true

            Label {
                id: time_label
                font.pixelSize: Qt.application.font.pixelSize * 2
                text: "12:00PM"
                horizontalAlignment: Text.AlignHCenter
                Layout.fillWidth: true
            }
        }

        // tumblers
        RowLayout {
            id: row_tumbler

            // hour
            Tumbler {
                id: hour_tumbler
                model: 12
                delegate: TumblerDelegate {
                    font.pixelSize: Qt.application.font.pixelSize * 1.4
                    text: alarm_model.format_number(modelData + 1)
                }
                onCurrentIndexChanged:{update_time_label()}
            }

            // minute
            Tumbler {
                id: minute_tumbler
                model: 60
                delegate: TumblerDelegate {
                    font.pixelSize: Qt.application.font.pixelSize * 1.4
                    text: alarm_model.format_number(modelData)
                }
                onCurrentIndexChanged:{update_time_label()}
            }

            // am/pm tumbler/state
            ColumnLayout {
                id: am_pm_tumbler
                state: "AM"
                onStateChanged:{update_time_label()}
                states: [
                    State {
                        name: "AM"
                        PropertyChanges { 
                            target: am
                            opacity: 1.0
                        }
                        PropertyChanges { 
                            target: pm
                            opacity: 0.5
                        }
                    },
                    State {
                        name: "PM"
                        PropertyChanges { 
                            target: am
                            opacity: 0.5
                        }
                        PropertyChanges { 
                            target: pm
                            opacity: 1.0
                        }
                    }
                ]
                Label {
                    id: am
                    text: "AM"
                    font.pixelSize: Qt.application.font.pixelSize * 1.4
                    padding: 6
                    MouseArea {
                        anchors.fill: parent
                        onClicked: am_pm_tumbler.state = "AM"
                    }
                }
                Label {
                    id: pm
                    text: "PM"
                    font.pixelSize: Qt.application.font.pixelSize * 1.4
                    padding: 6
                    MouseArea {
                        anchors.fill: parent
                        onClicked: am_pm_tumbler.state = "PM"
                    }
                }
            }
        }

    }
}
