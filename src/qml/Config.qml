pragma Singleton
import QtQuick 2.0

QtObject {
    objectName: "Config"

    readonly property variant default_alarms: [
        {
            hour: 7,
            minute: 0,
            day: 2,
            month: 8,
            year: 2018,
            activated: true,
            label: "Work",
            repeat: true,
            repeat_list: [1,3,5],
        },
        {
            hour: 9,
            minute: 0,
            day: 2,
            month: 8,
            year: 2018,
            activated: true,
            label: "Play",
            repeat: true,
            repeat_list: [0, 6],
        },
        {
            hour: 14,
            minute: 0,
            day: 2,
            month: 8,
            year: 2018,
            activated: true,
            label: "Reminder",
            repeat: false,
            repeat_list: [],
        },
    ]
}