import QtQuick 2.11
import Qt.labs.platform 1.1 // for standard paths
import Util 1.0
import "." // for singletons qmldir

// Populate the model with some sample data.
ListModel {
    id: alarm_model
    property string database_file: "alarm.json"

   onDataChanged: {
        save_data();
    }

    Component.onCompleted: {
        load_data();
    }

    Component.onDestruction: {
        save_data();
    }

    function format_number(number) {
        return number < 10 && number >= 0 ? "0" + number : number.toString()
    }


    function get_display_time(hour, minute) {
        if (hour > 12){
            hour -= 12
        }
        return hour + ":" + format_number(minute)
    }

    function get_am_pm(hour) {
        var am_pm = "AM"
        if (hour > 12){
            am_pm = "PM"
        }
        return am_pm
    }

    function load_data() {
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

        // database, or config
        var database_exists = Util.file_exists(database_file);
        // debug
        //database_exists = false; 

        var data_model = [];
        if (database_exists) {
            var data = Util.read_text_file(database_file);
            data_model = JSON.parse(data)
        } else {
            data_model = Config.default_alarms
        }

        for (var i = 0; i < data_model.length; ++i) {
            add_alarm(data_model[i], false) // dont want to save while loading
        }
    }

    function save_data() {
        console.log("save data");
        // write file
        Util.write_text_file(database_file, JSON.stringify(get_alarm_list()))
    }

    function get_alarm_list() {
        var temp_data = [];
        // loop over children
        for (var i = 0; i < count; ++i) {
            var child = get_alarm(i);
            temp_data.push(child)
        }
        return temp_data
    }

    function get_active_alarms(params){
        var result = []

        // loop over children
        for (var i = 0; i < count; ++i) {
            var alarm = get_alarm(i);
            if (alarm.hour == params.hour && alarm.minute == params.minute)
                result.push(alarm)
        }

        return result
    }

    function get_alarm(index) {
        var item = get(index);
        var alarm = {
            hour: item.hour,
            minute: item.minute,
            active: item.active,
            label: item.label,
            repeat: item.repeat,
            repeat_list: [],
        }
        // extract repeat list as json
        for (let i = 0; i < item.repeat_list.count; ++i) {
            let element = item.repeat_list.get(i);
            alarm.repeat_list.push({
                "day": element.day,
                "on": element.on,
            })
        }
        return alarm;
    }

    function set_alarm(index, params, update=true){
        // modifys an existing alarm
        var alarm = get(index)
        alarm.hour = params.hour
        alarm.minute = params.minute
        alarm.active = params.active
        alarm.label = params.label
        alarm.repeat = params.repeat
        alarm.repeat_list = params.repeat_list

        // save data
        if (update) {
            save_data()
        }
    }

    function add_alarm(params, update=true) {
        // day of week 1-6 = mon - fri
        // 6 = sat
        // 0 = sun
        //append(params)
        append({
            "hour": params.hour,
            "minute": params.minute,
            "active": params.active,
            "label": params.label,
            "repeat": params.repeat,
            "repeat_list": params.repeat_list,
        })

        // save data
        if (update) {
            save_data()
        }
    }

}
