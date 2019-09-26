import QtQuick 2.11
import Qt.labs.settings 1.0

// plugins
//import JsonSettings 1.0 as Database
import fileio 1.0

// Populate the model with some sample data.
ListModel {
    id: alarm_model
    property string data: ""

    // alarm model save/load
    // serialize model
    //Settings { id: settings; }

    Component.onCompleted: {
        console.log("Loading app...");

        // test data
        var alarm = {
            hour: 7,
            minute: 0,
            day: 2,
            month: 8,
            year: 2018,
            activated: true,
            label: "Work",
            repeat: true,
            repeat_list: [1,3,5],
        }
        add(alarm)


        if(count == 0) {
            //create database, insert default data
            console.log("First...");
            Storage.init_database();

        } else {
            //if necessary do something else
            console.log("Non-first...");
            /*
            AlarmModel.clear()
            var data_model = JSON.parse(alarm_model_data)
            for (var i = 0; i < data_model.length; ++i) {
                AlarmModel.append(data_model[i])
            }
            */

        }
    }

    Component.onDestruction: {
        // loop over children
        // get each child as json
        // stringify json
        var temp_data = []
        for (var i = 0; i < count; ++i) {
            temp_data.push(get(i))
        }
        data = JSON.stringify(temp_data)

        console.log(data)
    }


    onDataChanged: {
        console.log('Data Changed')
    }

    function get_alarm(index) {
        var item = get(index);
        var alarm = {
            hour: item.hour,
            minute: item.minute,
            day: item.day,
            month: item.month,
            year: item.year,
            activated: item.activated,
            label: item.label,
            repeat: item.repeat,
            repeat_list: item.repeat_list,
        }
        return alarm;
    }

    function add(params) {
        // day of week 1-6 = mon - fri
        // 6 = sat
        // 0 = sun
        //append(params)
        append({
            "hour": params.hour,
            "minute": params.minute,
            "day": params.day,
            "month": params.month,
            "year": params.year,
            "activated": params.activated,
            "label": params.label,
            "repeat": params.repeat,
            "repeat_list": params.repeat_list,
        })
    }

    /*
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
    */
}
