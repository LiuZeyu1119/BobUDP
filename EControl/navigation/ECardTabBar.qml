import QtQuick 2.12
import QtQuick.Controls 2.12

import EUIpackage 1.0

TabBar{
    id:rootTabBar
    width: contentWidth
    height: 50

    property var cusModel: ["项目1","项目2","项目3","项目4","项目5"]
    property int cusSpacing: 40
    property int cusBottomLineWid: width+200
    background: Rectangle{
        anchors.fill: parent
        radius: 4
        border.color: EColor.textColor(EColor.Text_Placeholder)
        border.width: 1
        color:"white"
        Rectangle{
            width: cusBottomLineWid
            height: 1
            color:EColor.textColor(EColor.Text_Placeholder)
            anchors.bottom: parent.bottom
            Rectangle{
                id:selectLine
                width:rootTabBar.currentItem.width
                height: 1
                anchors.bottom: parent.bottom
                color:"white"
                x:rootTabBar.currentItem.x
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
            padding: 1
            anchors.margins: 0
            background: Rectangle {
                width: parent.width
                height: parent.height-1
                color: "transparent"
                Rectangle{
                    width: 1
                    height: parent.height
                    color: EColor.textColor(EColor.Text_Placeholder)
                    anchors.right: parent.left
                    visible: index !== 0
                }
                Rectangle{//左下角圆角去除
                    width: 4
                    height: 4
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    visible: index === 0
                    color:"white"
                    Rectangle{
                        width: 1
                        height: parent.height
                        anchors.left: parent.left
                        color: EColor.textColor(EColor.Text_Placeholder)
                    }
                }
                Rectangle{//右下角圆角去除
                    width: 4
                    height: 4
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    visible: index === rootTabBar.count-1
                    color:"white"
                    Rectangle{
                        width: 1
                        height: parent.height
                        anchors.right: parent.right
                        color: EColor.textColor(EColor.Text_Placeholder)
                    }
                }
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
            }
            function getTextColor(){
                if(rootTabBar.currentIndex === index || hovered){
                    return EColor.mainColor(EColor.MColor_1)
                }
                else{
                    return EColor.textColor(EColor.Text_Routine)
                }
            }
        }//end TabButton
    }//end Repeater
}//end rootTabBar
