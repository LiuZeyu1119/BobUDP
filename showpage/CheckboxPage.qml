import QtQuick 2.0
import QtQuick.Controls 2.5

import EUIpackage 1.0
import EControl 1.0

Rectangle {
    color: EColor.bgColor(EColor.BGColor_1)

    Text {
        id:title1
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: 8
        text: qsTr("复选框")
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
        ECheckbox{
            text: "备选项"
        }
        ECheckbox{
            width: 120
            text: "三态复选框"
            tristate:true
        }
        ECheckbox{
            text: "禁用项"
            enabled: false
        }
        ECheckbox{
            width: 120
            text: "勾选禁用项"
            checked: true
            enabled: false
        }
    }

    Text {
        id:title2
        anchors.left: parent.left
        anchors.top: firstRow.bottom
        anchors.margins: 8
        text: qsTr("带边框的复选框")
        width: contentWidth
        height: contentHeight
        font.pixelSize: 20
        color: EColor.mainColor(EColor.MColor_1)
        font.family: EFont.textHanSansNormal
    }
    Row{
        id:secendRow
        anchors.top: title2.bottom
        anchors.left: parent.left
        anchors.margins: 8
        spacing: 6
        height: 40
        ECheckbox{
            text: "备选项"
            cusIsBorderBox: true
        }
        ECheckbox{
            width: 140
            text: "三态复选框"
            tristate:true
            cusIsBorderBox: true
        }
        ECheckbox{
            text: "禁用项"
            enabled: false
            cusIsBorderBox: true
        }
        ECheckbox{
            width: 140
            text: "勾选禁用项"
            checked: true
            enabled: false
            cusIsBorderBox: true
        }
    }

    ECheckbox {
        id: parentBox
        text: qsTr("全选")
        checkState: childGroup.checkState
        anchors.top: secendRow.bottom
        anchors.left: parent.left
        anchors.margins: 8
        height: 40
    }
    ButtonGroup {
        id: childGroup
        exclusive: false
        checkState: parentBox.checkState
    }
    Column {
        anchors.top: parentBox.bottom
        anchors.left: parent.left
        anchors.leftMargin: 28
        ECheckbox {
            checked: true
            text: qsTr("Child 1")
            ButtonGroup.group: childGroup
        }

        ECheckbox {
            text: qsTr("Child 2")

            ButtonGroup.group: childGroup
        }
        ECheckbox {
            text: qsTr("Child 3")
            ButtonGroup.group: childGroup
        }
    }
}
