pragma Singleton
import QtQuick 2.0

QtObject {
    objectName: "Config"

    readonly property variant default_alarms: [
        {
            hour: 7,
            minute: 0,
            active: true,
            label: "Work",
            repeat: true,
            repeat_list: [
                {"day": 0, "on": true},
                {"day": 1, "on": true},
                {"day": 2, "on": true},
                {"day": 3, "on": true},
                {"day": 4, "on": true},
                {"day": 5, "on": false}, // sat
                {"day": 6, "on": false}, // sun
            ]        
        },
        {
            hour: 9,
            minute: 0,
            active: true,
            label: "Play",
            repeat: true,
            repeat_list: [
                {"day": 0, "on": false},
                {"day": 1, "on": false},
                {"day": 2, "on": false},
                {"day": 3, "on": false},
                {"day": 4, "on": false},
                {"day": 5, "on": true}, // sat
                {"day": 6, "on": true}, // sun
            ]
        },
        {
            hour: 14,
            minute: 0,
            active: true,
            label: "Reminder",
            repeat: false,
            repeat_list: [
                {"day": 0, "on": false},
                {"day": 1, "on": false},
                {"day": 2, "on": false},
                {"day": 3, "on": false},
                {"day": 4, "on": false},
                {"day": 5, "on": false}, // sat
                {"day": 6, "on": false}, // sun
            ]
        },
    ]
}