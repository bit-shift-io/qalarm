import QtQuick 2.11

// Populate the model with some sample data.
ListModel {
    id: alarmModel

    ListElement {
        hour: 7
        minute: 0
        day: 2
        month: 8
        year: 2018
        activated: true
        label: "Work"
        repeat: true
        daysToRepeat: [
            ListElement { dayOfWeek: 1; repeat: true },
            ListElement { dayOfWeek: 2; repeat: true },
            ListElement { dayOfWeek: 3; repeat: true },
            ListElement { dayOfWeek: 4; repeat: true },
            ListElement { dayOfWeek: 5; repeat: false },
            ListElement { dayOfWeek: 6; repeat: false },
            ListElement { dayOfWeek: 0; repeat: true }
        ]
    }
    ListElement {
        hour: 9
        minute: 0
        day: 3
        month: 8
        year: 2018
        activated: true
        label: "Work"
        repeat: true
        daysToRepeat: [
            ListElement { dayOfWeek: 1; repeat: false },
            ListElement { dayOfWeek: 2; repeat: true },
            ListElement { dayOfWeek: 3; repeat: false },
            ListElement { dayOfWeek: 4; repeat: true },
            ListElement { dayOfWeek: 5; repeat: false },
            ListElement { dayOfWeek: 6; repeat: false },
            ListElement { dayOfWeek: 0; repeat: true }
        ]
    }
    ListElement {
        hour: 7
        minute: 0
        day: 3
        month: 8
        year: 2018
        activated: false
        label: "Excersise"
        repeat: true
        daysToRepeat: [
            ListElement { dayOfWeek: 1; repeat: true },
            ListElement { dayOfWeek: 2; repeat: true },
            ListElement { dayOfWeek: 3; repeat: true },
            ListElement { dayOfWeek: 4; repeat: true },
            ListElement { dayOfWeek: 5; repeat: true },
            ListElement { dayOfWeek: 6; repeat: true },
            ListElement { dayOfWeek: 0; repeat: true }
        ]
    }
    ListElement {
        hour: 5
        minute: 15
        day: 1
        month: 9
        year: 2018
        activated: true
        label: "Tomorrow"
        repeat: false
        daysToRepeat: [
            ListElement { dayOfWeek: 1; repeat: false },
            ListElement { dayOfWeek: 2; repeat: false },
            ListElement { dayOfWeek: 3; repeat: false },
            ListElement { dayOfWeek: 4; repeat: false },
            ListElement { dayOfWeek: 5; repeat: false },
            ListElement { dayOfWeek: 6; repeat: false },
            ListElement { dayOfWeek: 0; repeat: true }
        ]
    }
}
