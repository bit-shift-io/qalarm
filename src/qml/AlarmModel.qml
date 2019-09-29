import QtQuick 2.11
import Qt.labs.platform 1.1 // for standard paths
import Util 1.0
import "." // for singletons qmldir

// Populate the model with some sample data.
ListModel {
    id: alarm_model
    property string database_file: "alarm.json"

   onDataChanged: {
        console.log('Data Changed')
    }

    Component.onCompleted: {
        console.log("load data");

        // todo move to cpp
        // get the app config location
        var app_name = Qt.application.name;
        var str = StandardPaths.standardLocations(StandardPaths.AppConfigLocation)[0];
        str = str.replace("file://", "");
        var n = str.lastIndexOf(app_name);
        if (n >= 0 && n + app_name.length >= str.length) {
            str = str.substring(0, n);
        }
        database_file = str + database_file;
        console.log(database_file);

        var database_exists = Util.file_exists(database_file);
        //database_exists = false; // debug

        var data_model = [];
        if (database_exists) {
            var data = Util.read_text_file(database_file);
            data_model = JSON.parse(data)
        } else {
            data_model = Config.default_alarms
        }

        for (var i = 0; i < data_model.length; ++i) {
            add_alarm(data_model[i])
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
        // write file
        Util.write_text_file(database_file, JSON.stringify(temp_data))
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

    function add_alarm(params) {
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
