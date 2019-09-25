import QtQuick 2.11
import Qt.labs.settings 1.0

// Populate the model with some sample data.
ListModel {
    id: alarm_model

    ListElement {
        hour: 7
        minute: 0
        day: 2
        month: 8
        year: 2018
        activated: true
        label: "Work"
        repeat: true
        repeat_list: [
            ListElement { day_of_week: 1; repeat: true },
            ListElement { day_of_week: 2; repeat: true },
            ListElement { day_of_week: 3; repeat: true },
            ListElement { day_of_week: 4; repeat: true },
            ListElement { day_of_week: 5; repeat: false },
            ListElement { day_of_week: 6; repeat: false },
            ListElement { day_of_week: 0; repeat: true }
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
        repeat_list: [
            ListElement { day_of_week: 1; repeat: false },
            ListElement { day_of_week: 2; repeat: true },
            ListElement { day_of_week: 3; repeat: false },
            ListElement { day_of_week: 4; repeat: true },
            ListElement { day_of_week: 5; repeat: false },
            ListElement { day_of_week: 6; repeat: false },
            ListElement { day_of_week: 0; repeat: true }
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
        repeat_list: [
            ListElement { day_of_week: 1; repeat: false },
            ListElement { day_of_week: 2; repeat: false },
            ListElement { day_of_week: 3; repeat: false },
            ListElement { day_of_week: 4; repeat: false },
            ListElement { day_of_week: 5; repeat: false },
            ListElement { day_of_week: 6; repeat: false },
            ListElement { day_of_week: 0; repeat: true }
        ]
    }
}
