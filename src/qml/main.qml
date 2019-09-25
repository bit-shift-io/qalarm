import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.4
import QtQuick.Layouts 1.11
import QtQuick.Window 2.11
import Qt.labs.calendar 1.0
import Qt.labs.settings 1.0

ApplicationWindow {
    id: window
    width: 400
    height: 500
    visible: true

    // store window settings
    Settings {
        category: "window"
        property alias x: window.x
        property alias y: window.y
        property alias width: window.width
        property alias height: window.height
    }

    property string alarm_model_data: "" // store serialized object here for settings


    // alarm model save/load
    // serialize model
    Component.onCompleted: {
        if (alarm_model_data) {
            AlarmModel.clear()
            var data_model = JSON.parse(alarm_model_data)
            for (var i = 0; i < data_model.length; ++i) {
                AlarmModel.append(data_model[i])
            }
        }
    }

    onClosing: {
        var data_model = []
        for (var i = 0; i < data_model.count; ++i) {
            data_model.push(AlarmModel.get(i))
        }
        alarm_model_data = JSON.stringify(data_model)
    }

    Settings {
        category: "alarm_model"
        property alias alarm_model_data: window.alarm_model_data
    }
    

    ListView {
        id: alarmListView
        anchors.fill: parent
        model: AlarmModel {}
        delegate: AlarmDelegate {}
    }

    RoundButton {
        id: addAlarmButton
        text: "+"
        anchors.bottom: alarmListView.bottom
        anchors.bottomMargin: 8
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: alarmDialog.open()
    }

    AlarmDialog {
        id: alarmDialog
        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 2)
        alarmModel: alarmListView.model
    }
}
