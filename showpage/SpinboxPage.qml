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
        text: qsTr("spinbox输入框")
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
        ESpinBox{
        }
        ESpinBox{
            cusMaxValue: 9
            cusMinValue: 2
        }
        ESpinBox{
            enabled: false
        }
    }
}
