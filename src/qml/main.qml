import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.4
import QtQuick.Layouts 1.11
import QtQuick.Window 2.11
import Qt.labs.calendar 1.0
import Qt.labs.settings 1.0
import Qt.labs.platform 1.1 // sys tray


ApplicationWindow {
    id: window
    width: 350
    height: 500
    visible: true

    Settings {
        // window settings
        category: "window"
        property alias x: window.x
        property alias y: window.y
        property alias width: window.width
        property alias height: window.height
    }

    // alarm list
    ListView {
        id: alarm_list_view
        anchors.fill: parent
        model: AlarmModel {}
        delegate: AlarmDelegate {}
    }

    // add alarm button
    RoundButton {
        id: addAlarmButton
        text: "+"
        anchors.bottom: alarm_list_view.bottom
        anchors.bottomMargin: 8
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: alarm_dialog.open()
    }

    // dialog
    AlarmDialog {
        id: alarm_dialog
        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 2)
        alarm_model: alarm_list_view.model
    }

    /*
    // system tray
    SystemTrayIcon {
        visible: true
        //icon.source: "qrc:/images/tray-icon.png"

        onActivated: {
            window.show()
            window.raise()
            window.requestActivate()
        }
    }
    */
}
