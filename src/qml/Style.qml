pragma Singleton
import QtQuick 2.0

/*
Info on theme from here:
https://stackoverflow.com/questions/44389883/dynamically-change-qml-theme-at-runtime-on-mouseclick

more info here too:
http://imaginativethinking.ca/make-qml-component-singleton/
*/

Theme {
    // themes here
    property Theme current: theme1
    property Theme theme1: Theme1 { }

    // bind theme properties
    color0: (current && current.color0 ? current.color0 : 'defaultColor0')
    color1: (current && current.color1 ? current.color1 : 'defaultColor1')
}