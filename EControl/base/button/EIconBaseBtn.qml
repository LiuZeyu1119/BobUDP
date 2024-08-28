import QtQuick 2.0
import QtQuick.Controls 2.5

import EUIpackage 1.0

Button{
    id:rootBut
    width: 40
    height: width

    enum BtnStyle{
        Default,
        Simple
    }

    property var cusStyle: EIconBaseBtn.BtnStyle.Default
    property int cusIconSize:14
    property string cusIcon: "\uf002"

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
        border.width: 1
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

    function getBorderColor(){
        switch (cusStyle){
        case EIconBaseBtn.BtnStyle.Default:
            if(rootBut.pressed){
                return EColor.mainColor(EColor.MColor_1)
            }
            else{
                return EColor.borderColor(EColor.Border_1)
            }
        case EIconBaseBtn.BtnStyle.Simple:
            if(rootBut.pressed){
                return EColor.mainColor(EColor.MColor_5)
            }
            else if(bgRect.pressedState && rootBut.released){
                return EColor.mainColor(EColor.MColor_1)
            }
            else {
                if(rootBut.hovered){
                    return EColor.mainColor(EColor.MColor_1)
                }
                else{
                    return EColor.borderColor(EColor.Border_1)
                }
            }
        }
    }

    function getBgColor(){
        switch (cusStyle){
        case EIconBaseBtn.BtnStyle.Default:
            if(rootBut.hovered){
                return EColor.mainColor(EColor.MColor_10)
            }
            else{
                return "white"
            }
        case EIconBaseBtn.BtnStyle.Simple:
            return "white"
        }
    }

    function getTextColor(){
        switch (cusStyle){
        case EIconBaseBtn.BtnStyle.Default:
            if(rootBut.pressed){
                return EColor.mainColor(EColor.MColor_1)
            }
            else{
                return EColor.textColor(EColor.Text_Routine)
            }
        case EIconBaseBtn.BtnStyle.Simple:
            if(rootBut.pressed){
                return EColor.mainColor(EColor.MColor_5)
            }
            else if(bgRect.pressedState && rootBut.released){
                return EColor.mainColor(EColor.MColor_1)
            }
            else {
                if(rootBut.hovered){
                    return EColor.mainColor(EColor.MColor_1)
                }
                else{
                    return EColor.textColor(EColor.Text_Routine)
                }
            }
        }
    }
}
