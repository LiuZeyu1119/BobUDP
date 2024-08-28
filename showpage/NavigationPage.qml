import QtQuick 2.0

import EUIpackage 1.0
import EControl 1.0

Rectangle {
    id:rootPage
    color: EColor.bgColor(EColor.BGColor_1)

    Column{
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: 8
        width: 360
        spacing: 8
        Text {
            text: qsTr("基础标签导航")
            width: contentWidth
            height: contentHeight
            font.pixelSize: 20
            color: EColor.mainColor(EColor.MColor_1)
            font.family: EFont.textHanSansNormal
        }
        EBaseTabBar{
        }
        Text {
            text: qsTr("深色标签导航")
            width: contentWidth
            height: contentHeight
            font.pixelSize: 20
            color: EColor.mainColor(EColor.MColor_1)
            font.family: EFont.textHanSansNormal
        }
        EBaseTabBar{
            height:50
            cusSpacing:30
            cusModel:["首页","当前工作","账户管理","消息中心"]
            cusStyle:EBaseTabBar.TabBarStyle.Dark
        }
        Text {
            text: qsTr("选项卡标签导航")
            width: contentWidth
            height: contentHeight
            font.pixelSize: 20
            color: EColor.mainColor(EColor.MColor_1)
            font.family: EFont.textHanSansNormal
        }
        ECardTabBar{
            cusModel:["首页","当前工作","账户管理","消息中心"]
            cusBottomLineWid: rootPage.width
        }
    }
}

