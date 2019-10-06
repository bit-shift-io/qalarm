import QtQuick 2.0
import QtQuick.Controls.Material 2.4

Theme {
    property color color0: 'green'
    property color color1: 'white'

    // main body text
    property color font_default_color: 'blue'
    property string font_default_family: 'Sans'
    property int font_default_size: 9
    property int font_default_capitalization: Font.MixedCase

    // material theme
    // https://doc.qt.io/qt-5/qtquickcontrols2-material.html# for more
    property int material_theme: Material.Dark
    property color material_accent: "#F44336"
}
