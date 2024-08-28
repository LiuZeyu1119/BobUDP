import QtQuick 2.0

import EUIpackage 1.0
import EControl 1.0

Rectangle {
    color: EColor.bgColor(EColor.BGColor_1)

    Text {
        id:title1
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: 8
        text: qsTr("switch 开关")
        width: contentWidth
        height: contentHeight
        font.pixelSize: 20
        color: EColor.mainColor(EColor.MColor_1)
        font.family: EFont.textHanSansNormal
    }
    Row{
        id:firstRow
        anchors.top: title1.bottom
        anchors.left: parent.left
        anchors.margins: 8
        spacing: 6
        height: 40
        ESwitch{
        }
        ESwitch{
            cusCheckedColor: EColor.stateColor(EColor.Success_0)
            cusUnCheckedColor: EColor.stateColor(EColor.Danger_0)
        }
        ESwitch{
            enabled: false
        }
        ESwitch{
            checked: true
            enabled: false
        }
    }
}
