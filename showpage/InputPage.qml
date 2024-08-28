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
        text: qsTr("基础输入框")
        width: contentWidth
        height: contentHeight
        font.pixelSize: 20
        color: EColor.mainColor(EColor.MColor_1)
        font.family: EFont.textHanSansNormal
    }
    Row{
        id:firstRow
        height: 40
        anchors.left: parent.left
        anchors.top: title1.bottom
        anchors.margins: 8
        spacing: 8
        EBaseInput{
        }
        EBaseInput{
            placeholderText: "输入框"
        }
        EBaseInput{
            enabled: false
        }
    }


    Text {
        id:title2
        anchors.left: parent.left
        anchors.top: firstRow.bottom
        anchors.margins: 8
        text: qsTr("带清除的输入框")
        width: contentWidth
        height: contentHeight
        font.pixelSize: 20
        color: EColor.mainColor(EColor.MColor_1)
        font.family: EFont.textHanSansNormal
    }
    Row{
        id:secendRow
        height: 40
        anchors.left: parent.left
        anchors.top: title2.bottom
        anchors.margins: 8
        spacing: 8

        EClearableInput{
        }
        EClearableInput{
            placeholderText: "输入框"
        }
        EClearableInput{
            text: "hello"
            enabled: false
        }
    }

    Text {
        id:title3
        anchors.left: parent.left
        anchors.top: secendRow.bottom
        anchors.margins: 8
        text: qsTr("密码输入框")
        width: contentWidth
        height: contentHeight
        font.pixelSize: 20
        color: EColor.mainColor(EColor.MColor_1)
        font.family: EFont.textHanSansNormal
    }
    Row{
        height: 40
        anchors.left: parent.left
        anchors.top: title3.bottom
        anchors.margins: 8
        spacing: 8

        EPasswordInput {
        }
        EPasswordInput{
            placeholderText: "输入框"
        }
        EPasswordInput{
            text: "hello"
            enabled: false
        }
    }
}
