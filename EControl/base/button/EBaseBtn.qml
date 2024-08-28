import QtQuick 2.0
import QtQuick.Controls 2.5

import EUIpackage 1.0

Button{
    enum BtnStyle{
        Default,
        Simple
    }

    property string cusText: "按钮"
    property var cusStyle: EBaseBtn.BtnStyle.Default
    property int cusTextSize:14

    id:rootBut
    width: 120
    height: 50

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
        border.width: 1
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

    function getBorderColor(){
        switch (cusStyle){
        case EBaseBtn.BtnStyle.Default:
            if(rootBut.pressed){
                return EColor.mainColor(EColor.MColor_1)
            }
            else{
                return EColor.borderColor(EColor.Border_1)
            }
        case EBaseBtn.BtnStyle.Simple:
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
        case EBaseBtn.BtnStyle.Default:
            if(rootBut.hovered){
                return EColor.mainColor(EColor.MColor_10)
            }
            else{
                return "white"
            }
        case EBaseBtn.BtnStyle.Simple:
            return "white"
        }
    }

    function getTextColor(){
        switch (cusStyle){
        case EBaseBtn.BtnStyle.Default:
            if(rootBut.pressed){
                return EColor.mainColor(EColor.MColor_1)
            }
            else{
                return EColor.textColor(EColor.Text_Routine)
            }
        case EBaseBtn.BtnStyle.Simple:
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
