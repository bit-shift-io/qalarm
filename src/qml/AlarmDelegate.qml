import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.4
import QtQuick.Layouts 1.11
import QtQuick.Window 2.11

ItemDelegate {
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

            Repeater {
                id: day_repeater
                model: repeat_list
                delegate: RoundButton {
                    text: Qt.locale().dayName(model.day_of_week, Locale.NarrowFormat)
                    font.capitalization: Font.Capitalize
                    flat: true
                    checked: model.repeat
                    checkable: true
                    Material.background: checked ? Material.accent : "transparent"
                    onToggled: model.repeat = checked
                }
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
}
