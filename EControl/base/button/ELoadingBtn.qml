import QtQuick 2.0
import QtQuick.Controls 2.12

import EUIpackage 1.0

Button{
    id:rootBut
    width: cusWidth+ctnItem.width
    height: cusHeight

    //建议使用cusWidth 和cusHeight改变大小
    property int cusWidth: 50
    property int cusHeight: 50
    property int cusIconSize:14
    property string cusIcon: "\uf044"
    property string cusText: ""
    property bool cusIsLoading: false

    enabled: cusIsLoading? false: true
    onPressedChanged: {
        if(pressed){
            bgRect.pressedState = true
        }
        else{
            bgRect.pressedState = false
        }
    }
    background: Rectangle{
        id:bgRect
        anchors.fill: parent
        radius: 4
        color: getBgColor()
        property bool pressedState: false
        Item {
            id:ctnItem
            anchors.centerIn: parent
            width: cusText === ""?iconText.width :iconText.width+nameText.width+4
            height: rootBut.height
            Text {
                id:iconText
                text: cusIsLoading? "\uf110" :rootBut.cusIcon
                font.pixelSize: cusIconSize
                width: contentWidth
                height: contentHeight
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                color: "white"
                font.family: EFont.iconRegular
                RotationAnimation on rotation {
                    from: 0
                    to: 360
                    duration: 1000
                    loops: Animation.Infinite           //重复次数
                    running: cusIsLoading
                }
            }
            Text {
                id:nameText
                text: cusIsLoading? "加载中" : cusText
                font.pixelSize: cusIconSize
                anchors.left: iconText.right
                anchors.leftMargin: 4
                width: contentWidth
                height: contentHeight
                anchors.verticalCenter: parent.verticalCenter
                color: "white"
                font.family: EFont.textHanSansMedium
            }
        }

        Rectangle{
            color: EColor.bgColor(EColor.BGColor_2)
            opacity: 0.5
            visible: !rootBut.enabled
            anchors.fill: parent
        }
    }

    onCusIsLoadingChanged: {
        if(!cusIsLoading){
            iconText.rotation = 0
        }
    }

    function getBgColor(){
        if(rootBut.pressed){
            return EColor.mainColor(EColor.MColor_0);
        }
        else if( bgRect.pressedState && rootBut.released){
            return EColor.mainColor(EColor.MColor_1);
        }
        else{
            if(rootBut.hovered){
                return EColor.mainColor(EColor.MColor_1);
            }
            else{
                return EColor.mainColor(EColor.MColor_0);
            }
        }
    }
}