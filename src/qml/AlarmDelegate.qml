import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.4
import QtQuick.Layouts 1.11
import QtQuick.Window 2.11

ItemDelegate {
    property variant days_of_week : [1,2,3,4,5,6,0] // fixed

    id: alarm_delegate
    width: parent.width
    checkable: true
    onClicked: ListView.view.currentIndex = index
    contentItem: ColumnLayout {
        spacing: 0

        // alarm overview
        RowLayout {
            ColumnLayout {
                id: dateColumn

                readonly property date alarmDate: new Date(
                    model.year, model.month - 1, model.day, model.hour, model.minute)

                Label {
                    id: time_label
                    font.pixelSize: Qt.application.font.pixelSize * 2
                    text: dateColumn.alarmDate.toLocaleTimeString(window.locale, Locale.ShortFormat)
                }
                RowLayout {
                    // repeat label
                    Label {
                        id: alarm_days
                        visible: model.repeat && !alarm_delegate.checked
                        font.capitalization: Font.Capitalize
                        function get_string(){
                            var str = "";
                            for (let i = 0; i < model.repeat_list.count; ++i) {
                                let day = model.repeat_list.get(i);
                                if (day.repeat) {
                                    str += Qt.locale().dayName(day.day_of_week, Locale.NarrowFormat) + " ";
                                }
                            }
                            
                            str += "⸱"
                            return str;
                        }
                        text: get_string()
                    }

                    // alarm label
                    Label {
                        id: alarm_label
                        text: model.label
                        visible: model.label.length > 0 && !alarm_delegate.checked
                    }
                }
            }
            Item {
                Layout.fillWidth: true
            }
            Switch {
                checked: model.activated
                Layout.alignment: Qt.AlignTop
                onClicked: model.activated = checked
            }
        }

        // alarm toggle
        CheckBox {
            id: alarm_repeat
            text: qsTr("Repeat")
            checked: model.repeat
            visible: alarm_delegate.checked
            onToggled: model.repeat = checked
        }

        // this is the expanding section bellow
        // visible when alarm_delegate.checked

        // flow is the repeating day names
        Flow {
            visible: alarm_delegate.checked && model.repeat
            Layout.fillWidth: true

            RoundButton {
                id: monday
                text: Qt.locale().dayName(days_of_week[0], Locale.NarrowFormat)
                font.capitalization: Font.Capitalize
                checkable: true
                checked: is_checked(0)
                Material.background: checked ? Material.accent : "transparent"
                onToggled: model.repeat = checked
            }
            RoundButton {
                id: tuesday
                text: Qt.locale().dayName(days_of_week[1], Locale.NarrowFormat)
                font.capitalization: Font.Capitalize
                checkable: true
                checked: is_checked(1)
                Material.background: checked ? Material.accent : "transparent"
                onToggled: model.repeat = checked
            }
            RoundButton {
                id: wednesday
                text: Qt.locale().dayName(days_of_week[2], Locale.NarrowFormat)
                font.capitalization: Font.Capitalize
                checkable: true
                checked: is_checked(2)
                Material.background: checked ? Material.accent : "transparent"
                onToggled: model.repeat = checked
            }
            RoundButton {
                id: thursday
                text: Qt.locale().dayName(days_of_week[3], Locale.NarrowFormat)
                font.capitalization: Font.Capitalize
                checkable: true
                checked: is_checked(3)
                Material.background: checked ? Material.accent : "transparent"
                onToggled: model.repeat = checked
            }
            RoundButton {
                id: friday
                text: Qt.locale().dayName(days_of_week[4], Locale.NarrowFormat)
                font.capitalization: Font.Capitalize
                checkable: true
                checked: is_checked(4)
                Material.background: checked ? Material.accent : "transparent"
                onToggled: model.repeat = checked
            }
            RoundButton {
                id: saturday
                text: Qt.locale().dayName(days_of_week[5], Locale.NarrowFormat)
                font.capitalization: Font.Capitalize
                checkable: true
                checked: is_checked(5)
                Material.background: checked ? Material.accent : "transparent"
                onToggled: model.repeat = checked
            }
            RoundButton {
                id: sunday
                text: Qt.locale().dayName(days_of_week[6], Locale.NarrowFormat)
                font.capitalization: Font.Capitalize
                checkable: true
                checked: is_checked(6)
                Material.background: checked ? Material.accent : "transparent"
                onToggled: model.repeat = checked
            }
        }

        TextField {
            id: alarm_description
            placeholderText: qsTr("Enter description here")
            cursorVisible: true
            visible: alarm_delegate.checked
            text: model.label
            onTextEdited: model.label = text
        }
        Button {
            id: delete_alarm
            text: qsTr("Delete")
            width: 40
            height: 40
            visible: alarm_delegate.checked
            onClicked: alarm_delegate.ListView.view.model.remove(alarm_delegate.ListView.view.currentIndex, 1)
        }
    }

    function is_checked(p) {
        for (let i = 0; i < model.repeat_list.count; ++i) {
            if (model.repeat_list[i] == p)
                return true;
        }
        return false;
    }
}
