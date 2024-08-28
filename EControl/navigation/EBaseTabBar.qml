import QtQuick 2.12
import QtQuick.Controls 2.12

import EUIpackage 1.0

TabBar{
    id:rootTabBar
    width: contentWidth
    height: 50

    property var cusStyle: EBaseTabBar.TabBarStyle.Default
    property var cusModel: ["项目1","项目2","项目3","项目4","项目5"]
    property int cusSpacing: 40
    enum TabBarStyle{
        Default,
        Dark
    }
    background: Rectangle{
        anchors.fill: parent
        color:cusStyle === EBaseTabBar.TabBarStyle.Default ?
                  "white" :"#545c64"
        Rectangle{
            width: parent.width
            height: 2
            color: EColor.textColor(EColor.Text_Placeholder)
            anchors.bottom: parent.bottom
            Rectangle{
                id:selectLine
                width:rootTabBar.currentItem.width
                height: 2
                anchors.bottom: parent.bottom
                color: cusStyle === EBaseTabBar.TabBarStyle.Default ?
                           EColor.mainColor(EColor.MColor_1) :"#ffd04b"
                NumberAnimation {
                    id:changeAnimat
                    target: selectLine
                    property: "x"
                    duration: 160
                }
            }
        }
    }


    Repeater {
        id:repeater
        model: cusModel
        TabButton {
            id:tabBtn
            text: modelData
            width: contentext.contentWidth+cusSpacing
            height: parent.height
            anchors.verticalCenter: parent.verticalCenter
            padding: 0
            anchors.margins: 0
            background: Rectangle {
                width: parent.width
                height: parent.height-2
                color: parent.getBgColor()

            }
            contentItem: Text{
                id:contentext
                width: contentWidth
                height: contentHeight
                wrapMode: Text.NoWrap
                font.pixelSize: 14
                font.family: EFont.textHanSansNormal
                color: parent.getTextColor()
                text: parent.text
                horizontalAlignment:Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            onClicked: {
                rootTabBar.currentIndex = index
                changeAnimat.from = selectLine.x
                changeAnimat.to = tabBtn.x
                changeAnimat.start()
            }
            function getTextColor(){
                if(cusStyle === EBaseTabBar.TabBarStyle.Default ){
                    if(rootTabBar.currentIndex === index){
                        return EColor.mainColor(EColor.MColor_1)
                    }
                    else if(hovered){
                        return EColor.mainColor(EColor.MColor_1)
                    }
                    else{
                        return EColor.textColor(EColor.Text_Routine)
                    }
                }
                else{
                    if(rootTabBar.currentIndex === index){
                        return "#ffd04b"
                    }
                    else{
                        return "white"
                    }
                }
            }

            function getBgColor(){
                if(cusStyle === EBaseTabBar.TabBarStyle.Default ){
                    return "transparent"
                }
                else{
                    if(hovered)
                        return "#434a50"
                    else
                        return "transparent"
                }
            }
        }//end TabButton
    }//end Repeater
}//end rootTabBar
