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

    property var cusStyle: EIconSuccessBtn.BtnStyle.Default
    property int cusIconSize:14
    property string cusIcon: "\uf00c"

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
        border.width:cusStyle === EIconSuccessBtn.BtnStyle.Default ? 0 :1
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
        case EIconSuccessBtn.BtnStyle.Default:
            if(rootBut.pressed){
                return EColor.stateColor(EColor.Success_0)
            }
            else if( bgRect.pressedState && rootBut.released){
                return EColor.stateColor(EColor.Success_1)
            }
            else{
                if(rootBut.hovered){
                    return EColor.stateColor(EColor.Success_1)
                }
                else{
                    return EColor.stateColor(EColor.Success_0)
                }
            }
        case EIconSuccessBtn.BtnStyle.Simple:
            if(rootBut.pressed){
                return EColor.stateColor(EColor.Success_1)
            }
            else if( bgRect.pressedState && rootBut.released){
                return EColor.stateColor(EColor.Success_3)
            }
            else{
                if(rootBut.hovered){
                    return EColor.stateColor(EColor.Success_0)
                }
                else{
                    return EColor.stateColor(EColor.Success_3)
                }
            }
        }
    }

    function getBorderColor(){
        switch (rootBut.cusStyle){
        case EIconSuccessBtn.BtnStyle.Default:
            return  "white"
        case EIconSuccessBtn.BtnStyle.Simple:
            if(rootBut.pressed){
                return EColor.stateColor(EColor.Success_1)
            }
            else{
                return EColor.stateColor(EColor.Success_0)
            }
        }
    }

    function getTextColor(){
        switch (rootBut.cusStyle){
        case EIconSuccessBtn.BtnStyle.Default:
            return  "white"
        case EIconSuccessBtn.BtnStyle.Simple:
            if(rootBut.pressed){
                return  "white"
            }
            else if( bgRect.pressedState && rootBut.released){
                return EColor.stateColor(EColor.Success_0)
            }
            else{
                if(rootBut.hovered){
                    return  "white"
                }
                else{
                    return EColor.stateColor(EColor.Success_0)
                }
            }
        }
    }
}
