import QtQuick 2.0
import QtQuick.Controls 2.5

import EUIpackage 1.0

ProgressBar {
    id: rootProgressBar
    to: 100
    from:0
    value: 8
    width: 160
    height: 8
    property color cusColor: EColor.mainColor(EColor.MColor_0)
    background: Rectangle {
        implicitWidth: rootProgressBar.width
        implicitHeight: rootProgressBar.height
        color: EColor.borderColor(EColor.Border_3)
        radius: rootProgressBar.height/2
    }

    contentItem: Item {
        Rectangle {
            width: rootProgressBar.visualPosition * rootProgressBar.width
            height: rootProgressBar.height
            radius: rootProgressBar.height/2
            color: rootProgressBar.cusColor
        }
    }
}
