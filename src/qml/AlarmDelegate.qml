import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.4
import QtQuick.Layouts 1.11
import QtQuick.Window 2.11

ItemDelegate {
    id: root
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
                    id: timeLabel
                    font.pixelSize: Qt.application.font.pixelSize * 2
                    text: dateColumn.alarmDate.toLocaleTimeString(window.locale, Locale.ShortFormat)
                }
                RowLayout {
                    // repeat label
                    Label {
                        id: alarm_days
                        visible: model.repeat && !root.checked
                        font.capitalization: Font.Capitalize
                        function get_string(){
                            var str = "";
                            for (let i = 0; i < model.daysToRepeat.count; ++i) {
                                let day = model.daysToRepeat.get(i);
                                if (day.repeat) {
                                    str += Qt.locale().dayName(day.dayOfWeek, Locale.NarrowFormat) + " ";
                                }
                            }
                            
                            str += "⸱"
                            return str;
                        }
                        text: get_string()
                    }

                    // alarm label
                    Label {
                        id: alarmAbout
                        text: model.label
                        visible: model.label.length > 0 && !root.checked
                    }

                    /*
                    // repeater
                    Item {
                        visible: model.repeat

                        Repeater {
                            id: repeat_label
                            model: daysToRepeat
                            delegate: Label {
                                text: Qt.locale().dayName(model.dayOfWeek, Locale.NarrowFormat)
                                font.capitalization: Font.Capitalize
                                visible: model.repeat
                            }
                        }

                        Label {
                            id: spacer
                            text: "⸱ "
                            visible: model.repeat
                        }
                    }
                    */
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
            id: alarmRepeat
            text: qsTr("Repeat")
            checked: model.repeat
            visible: root.checked
            onToggled: model.repeat = checked
        }

        // this is the expanding section bellow
        // visible when root.checked

        // flow is the repeating day names
        Flow {
            visible: root.checked && model.repeat
            Layout.fillWidth: true

            Repeater {
                id: dayRepeater
                model: daysToRepeat
                delegate: RoundButton {
                    text: Qt.locale().dayName(model.dayOfWeek, Locale.NarrowFormat)
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
            id: alarmDescriptionTextField
            placeholderText: qsTr("Enter description here")
            cursorVisible: true
            visible: root.checked
            text: model.label
            onTextEdited: model.label = text
        }
        Button {
            id: deleteAlarmButton
            text: qsTr("Delete")
            width: 40
            height: 40
            visible: root.checked
            onClicked: root.ListView.view.model.remove(root.ListView.view.currentIndex, 1)
        }
    }
}
