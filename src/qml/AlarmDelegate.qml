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
                id: date_column

                RowLayout {
                    // time label
                    Label {
                        id: time_label
                        font.pixelSize: Qt.application.font.pixelSize * 2
                        text: alarm_model.get_display_time(model.hour, model.minute)
                    }

                    // am pm label
                    Label {
                        id: am_pm_label
                        font.pixelSize: Qt.application.font.pixelSize * 1.4
                        text: alarm_model.get_am_pm(model.hour)
                        anchors.baseline: time_label.baseline;
                    }

              
                    MouseArea {
                        anchors.fill: parent
                        //Layout.fillWidth: true
                        //Layout.fillHeight: true
                        onClicked: {
                            alarm_dialog.open() // from main.qml
                            alarm_dialog.set_alarm_index(index)
                        }
                    }
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
                                let item = model.repeat_list.get(i);
                                if (item.on == true) {
                                    str += Qt.locale().dayName(days_of_week[item.day], Locale.NarrowFormat) + " ";
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
                checked: model.active
                Layout.alignment: Qt.AlignTop
                onClicked: model.active = checked
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
                property int day: 0
                text: Qt.locale().dayName(days_of_week[day], Locale.NarrowFormat)
                font.capitalization: Font.Capitalize
                checkable: true
                checked: is_day_checked(day)
                Material.background: checked ? Material.accent : "transparent"
                onToggled: set_day_checked(day, checked)
            }
            RoundButton {
                id: tuesday
                property int day: 1
                text: Qt.locale().dayName(days_of_week[day], Locale.NarrowFormat)
                font.capitalization: Font.Capitalize
                checkable: true
                checked: is_day_checked(day)
                Material.background: checked ? Material.accent : "transparent"
                onToggled: set_day_checked(day, checked)
            }
            RoundButton {
                id: wednesday
                property int day: 2
                text: Qt.locale().dayName(days_of_week[day], Locale.NarrowFormat)
                font.capitalization: Font.Capitalize
                checkable: true
                checked: is_day_checked(day)
                Material.background: checked ? Material.accent : "transparent"
                onToggled: set_day_checked(day, checked)
            }
            RoundButton {
                id: thursday
                property int day: 3
                text: Qt.locale().dayName(days_of_week[day], Locale.NarrowFormat)
                font.capitalization: Font.Capitalize
                checkable: true
                checked: is_day_checked(day)
                Material.background: checked ? Material.accent : "transparent"
                onToggled: set_day_checked(day, checked)
            }
            RoundButton {
                id: friday
                property int day: 4
                text: Qt.locale().dayName(days_of_week[day], Locale.NarrowFormat)
                font.capitalization: Font.Capitalize
                checkable: true
                checked: is_day_checked(day)
                Material.background: checked ? Material.accent : "transparent"
                onToggled: set_day_checked(day, checked)
            }
            RoundButton {
                id: saturday
                property int day: 5
                text: Qt.locale().dayName(days_of_week[day], Locale.NarrowFormat)
                font.capitalization: Font.Capitalize
                checkable: true
                checked: is_day_checked(day)
                Material.background: checked ? Material.accent : "transparent"
                onToggled: set_day_checked(day, checked)
            }
            RoundButton {
                id: sunday
                property int day: 6
                text: Qt.locale().dayName(days_of_week[day], Locale.NarrowFormat)
                font.capitalization: Font.Capitalize
                checkable: true
                checked: is_day_checked(day)
                Material.background: checked ? Material.accent : "transparent"
                onToggled: set_day_checked(day, checked)
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

        // bottom divider
        MenuSeparator {
            padding: 0
            topPadding: 15
            bottomPadding: 8
            width: parent.width
            contentItem: Rectangle {
                implicitHeight: 2
                //implicitWidth: 20
                width: parent.width
                opacity: 0.2
            }
        }

    }

    function set_day_checked(p, checked) {

    }

    function is_day_checked(p) {
        if (model.repeat_list.get(p).on == true)
            return true;
        return false;
    }
}
