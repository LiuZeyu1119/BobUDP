import QtQuick 2.0
import QtQuick.Controls 2.5

import EUIpackage 1.0

Slider {
    id:rootSlider
    from: 0
    value: 25
    to: 100
    width: 160
    implicitHeight: 24
    stepSize:1
    background: Rectangle {
        x: rootSlider.leftPadding
        y: rootSlider.topPadding + rootSlider.availableHeight / 2 - height / 2
        implicitWidth: parent.width
        implicitHeight: 6
        width: rootSlider.availableWidth
        height: implicitHeight
        radius: 3
        color: EColor.borderColor(EColor.Border_2)

        Rectangle {
            width: rootSlider.visualPosition * parent.width
            height: parent.height
            color:rootSlider.enabled? EColor.mainColor(EColor.MColor_1) :EColor.textColor(EColor.Text_Placeholder)
            radius: 3
        }
    }
    handle: Rectangle {
        x: rootSlider.leftPadding + rootSlider.visualPosition * (rootSlider.availableWidth - width)
        y: rootSlider.topPadding + rootSlider.availableHeight / 2 - height / 2
        implicitWidth: rootSlider.hovered || rootSlider.pressed? 24 :20
        implicitHeight:implicitWidth
        radius: implicitWidth/2
        color: "white"
        border.width: 2
        border.color:rootSlider.enabled? EColor.mainColor(EColor.MColor_1) :EColor.textColor(EColor.Text_Placeholder)
    }
}
