import QtQuick 2.0

import EUIpackage 1.0
import EControl 1.0
import QtQml.Models 2.13

Rectangle {
    color: EColor.bgColor(EColor.BGColor_1)
    Text {
        id:title1
        anchors.left: parent.left
        anchors.top: parent.top
        text: qsTr("model类型为数组")
        width: contentWidth
        height: contentHeight
        font.pixelSize: 20
        anchors.margins: 8
        color: EColor.mainColor(EColor.MColor_1)
        font.family: EFont.textHanSansNormal
    }
    ECombobox{
        id:ecombox1
        anchors.top:title1.bottom
        model: ["1","2","3","4","5","6","7","8"]
    }

    Text {
        id:title2
        anchors.left: ecombox1.right
        anchors.top: parent.top
        anchors.margins: 8
        text: qsTr("model类型为listmodel")
        width: contentWidth
        height: contentHeight
        font.pixelSize: 20
        color: EColor.mainColor(EColor.MColor_1)
        font.family: EFont.textHanSansNormal
    }
    ECombobox{
        id:ecombox2
        anchors.top:title2.bottom
        anchors.left: title2.left
        textRole:"key"
        model:  ListModel{
            ListElement{
                key:"广州"
                value:"Guangzhou"
            }
            ListElement{
                key:"上海"
                value:"Shanghai"
            }
            ListElement{
                key:"北京"
                value:"Beijing"
            }
        }
    }

    Text {
        id:title3
        anchors.left: title2.right
        anchors.top: parent.top
        anchors.margins: 8
        text: qsTr("禁用状态")
        width: contentWidth
        height: contentHeight
        font.pixelSize: 20
        color: EColor.mainColor(EColor.MColor_1)
        font.family: EFont.textHanSansNormal
    }
    ECombobox{
        id:ecombox3
        anchors.top:title3.bottom
        anchors.left: title3.left
        textRole:"key"
        enabled: false
        model:  ListModel{
            ListElement{
                key:"广州"
                value:"Guangzhou"
            }
            ListElement{
                key:"上海"
                value:"Shanghai"
            }
            ListElement{
                key:"北京"
                value:"Beijing"
            }
        }
    }
}
