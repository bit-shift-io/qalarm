import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.11
import QtQuick.Window 2.11

Dialog {
    id: alarm_dialog
    title: "Add alarm"
    modal: true
    standardButtons: DialogButtonBox.Ok | DialogButtonBox.Cancel

    property AlarmModel alarm_model

    function format_number(number) {
        return number < 10 && number >= 0 ? "0" + number : number.toString()
    }

    onAccepted: {
        alarm_model.add_alarm({
            "hour": hoursTumbler.currentIndex,
            "minute": minutesTumbler.currentIndex,
            "day": dayTumbler.currentIndex + 1,
            "month": monthTumbler.currentIndex + 1,
            "year": yearTumbler.years[yearTumbler.currentIndex],
            "activated": true,
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
        })
    }
    onRejected: alarm_dialog.close()

    contentItem: RowLayout {
        RowLayout {
            id: rowTumbler

            Tumbler {
                id: hoursTumbler
                model: 24
                delegate: TumblerDelegate {
                    text: format_number(modelData)
                }
            }
            Tumbler {
                id: minutesTumbler
                model: 60
                delegate: TumblerDelegate {
                    text: format_number(modelData)
                }
            }
        }

        /*
        RowLayout {
            id: datePicker

            Layout.leftMargin: 20

            property alias dayTumbler: dayTumbler
            property alias monthTumbler: monthTumbler
            property alias yearTumbler: yearTumbler

            readonly property var days: [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

            Tumbler {
                id: dayTumbler

                function updateModel() {
                    // Populate the model with days of the month. For example: [0, ..., 30]
                    var previousIndex = dayTumbler.currentIndex
                    var array = []
                    var newDays = datePicker.days[monthTumbler.currentIndex]
                    for (var i = 1; i <= newDays; ++i)
                        array.push(i)
                    dayTumbler.model = array
                    dayTumbler.currentIndex = Math.min(newDays - 1, previousIndex)
                }

                Component.onCompleted: updateModel()

                delegate: TumblerDelegate {
                    text: format_number(modelData)
                }
            }
            Tumbler {
                id: monthTumbler

                onCurrentIndexChanged: dayTumbler.updateModel()

                model: 12
                delegate: TumblerDelegate {
                    text: window.locale.standaloneMonthName(modelData, Locale.ShortFormat)
                }
            }
            Tumbler {
                id: yearTumbler

                // This array is populated with the next three years. For example: [2018, 2019, 2020]
                readonly property var years: (function() {
                    var currentYear = new Date().getFullYear()
                    return [0, 1, 2].map(function(value) { return value + currentYear; })
                })()

                model: years
                delegate: TumblerDelegate {
                    text: format_number(modelData)
                }
            }
        }
        */
    }
}
