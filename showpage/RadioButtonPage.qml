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
        text: qsTr("单选按钮")
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
        Repeater{
            model: 6
            ERadioBtn{
                text:"备选项"+index
            }
        }
    }

    Text {
        id:title2
        anchors.left: parent.left
        anchors.top: firstRow.bottom
        anchors.margins: 8
        text: qsTr("带边框的单选按钮")
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
        Repeater{
            model: 6
            ERadioBtn{
                width:110
                text:"备选项"+index
                cusIsBorderBtn: true
            }
        }
    }

    Text {
        id:title3
        anchors.left: parent.left
        anchors.top: secendRow.bottom
        anchors.margins: 8
        text: qsTr("垂直排列及其禁用状态")
        width: contentWidth
        height: contentHeight
        font.pixelSize: 20
        color: EColor.mainColor(EColor.MColor_1)
        font.family: EFont.textHanSansNormal
    }
    Column {
        id:firstColum
        anchors.top: title3.bottom
        anchors.left: parent.left
        anchors.margins: 8
        spacing: 6
        width: 140
        Repeater{
            model: 6
            ERadioBtn{
                text:"备选项"+index
            }
        }
    }
    Column {
        id:secendColumm
        anchors.top: title3.bottom
        anchors.left: firstColum.right
        anchors.margins: 8
        spacing: 6
        width: 140
        Repeater{
            model: 6
            ERadioBtn{
                text:"备选项"+index
                enabled: false
            }
        }
    }
    Column {
        id:thirdColumn
        anchors.top: title3.bottom
        anchors.left: secendColumm.right
        anchors.margins: 8
        spacing: 6
        width: 140
        Repeater{
            model: 6
            ERadioBtn{
                width:120
                text:"备选项"+index
                cusIsBorderBtn: true
            }
        }
    }
    Column {
        id:fourthColumn
        anchors.top: title3.bottom
        anchors.left: thirdColumn.right
        anchors.margins: 8
        spacing: 6
        width: 140
        Repeater{
            model: 6
            ERadioBtn{
                width:120
                text:"备选项"+index
                enabled: false
                cusIsBorderBtn: true
            }
        }
    }
}
