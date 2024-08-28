import QtQuick 2.0
import QtQuick.Controls 2.12

import EUIpackage 1.0

Button{
    id:rootBut
    width: 120
    height: 50

    enum BtnStyle{
        Default,
        Simple
    }
    property string cusText: "按钮"
    property var cusStyle: EMainBtn.BtnStyle.Default
    property int cusTextSize:14

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
        border.width:cusStyle === EMainBtn.BtnStyle.Default ? 0 :1
        border.color: getBorderColor()
        color: getBgColor()
        property bool pressedState: false
        Text {
            text: rootBut.cusText
            font.pixelSize: cusTextSize
            width: parent.width/4*3
            height: contentHeight
            anchors.centerIn: parent
            verticalAlignment:Text.AlignVCenter
            horizontalAlignment:Text.AlignHCenter
            elide:Text.ElideMiddle
            wrapMode:Text.NoWrap
            color: getTextColor()
            font.family: EFont.textHanSansMedium
        }
        Rectangle{
            color: EColor.bgColor(EColor.BGColor_2)
            opacity: 0.5
            visible: !rootBut.enabled
            anchors.fill: parent
        }
    }
    function getBgColor(){
        switch (rootBut.cusStyle){
        case EMainBtn.BtnStyle.Default:
            if(rootBut.pressed){
                return EColor.mainColor(EColor.MColor_0);
            }
            else if(bgRect.pressedState && rootBut.released){
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
        case EMainBtn.BtnStyle.Simple:
            if(rootBut.pressed){
                return EColor.mainColor(EColor.MColor_2);
            }
            else if(bgRect.pressedState && rootBut.released){
                return EColor.mainColor(EColor.MColor_10);
            }
            else{
                if(rootBut.hovered){
                    return EColor.mainColor(EColor.MColor_0);
                }
                else{
                    return EColor.mainColor(EColor.MColor_10);
                }
            }
        }
    }

    function getBorderColor(){
        switch (rootBut.cusStyle){
        case EMainBtn.BtnStyle.Default:
            return  "white"
        case EMainBtn.BtnStyle.Simple:
            if(rootBut.pressed){
                return EColor.mainColor(EColor.MColor_2);
            }
            else{
                return EColor.mainColor(EColor.MColor_1);
            }
        }
    }

    function getTextColor(){
        switch (rootBut.cusStyle){
        case EMainBtn.BtnStyle.Default:
            return  "white"
        case EMainBtn.BtnStyle.Simple:
            if(rootBut.pressed){
                return  "white"
            }
            else if( bgRect.pressedState && rootBut.released){
                return EColor.mainColor(EColor.MColor_1);
            }
            else{
                if(rootBut.hovered){
                    return  "white"
                }
                else{
                    return EColor.mainColor(EColor.MColor_1);
                }
            }
        }
    }
}
