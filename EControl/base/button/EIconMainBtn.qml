import QtQuick 2.0
import QtQuick.Controls 2.12

import EUIpackage 1.0

Button{
    id:rootBut
    width: 40
    height: width

    enum BtnStyle{
        Default,
        Simple
    }

    property var cusStyle: EIconMainBtn.BtnStyle.Default
    property int cusIconSize:14
    property string cusIcon: "\uf044"

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
        radius: rootBut.width/2
        border.width:cusStyle === EIconMainBtn.BtnStyle.Default ? 0 :1
        border.color: getBorderColor()
        color: getBgColor()
        property bool pressedState: false
        Text {
            text: rootBut.cusIcon
            font.pixelSize: cusIconSize
            width: contentWidth
            height: contentHeight
            anchors.centerIn: parent
            color: getTextColor()
            font.family: EFont.iconRegular
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
        case EIconMainBtn.BtnStyle.Default:
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
        case EIconMainBtn.BtnStyle.Simple:
            if(rootBut.pressed){
                return EColor.mainColor(EColor.MColor_2);
            }
            else if( bgRect.pressedState && rootBut.released){
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
        case EIconMainBtn.BtnStyle.Default:
            return  "white"
        case EIconMainBtn.BtnStyle.Simple:
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
        case EIconMainBtn.BtnStyle.Default:
            return  "white"
        case EIconMainBtn.BtnStyle.Simple:
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
