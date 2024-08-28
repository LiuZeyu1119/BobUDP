import QtQuick 2.0
import QtQuick.Controls 2.5

import EUIpackage 1.0


Control {
    id:rootSpinbox
    width: 160
    height: 40
    property int cusMaxValue: 100
    property int cusMinValue: 0
    property int cusStep: 1
    property int cusValue: cusMinValue
    background: Rectangle{
        radius: 4
        border.color: spinInput.focus || upMouseArea.containsMouse || downMouseArea.containsMouse? EColor.mainColor(EColor.MColor_1) :
                rootSpinbox.hovered? EColor.textColor(EColor.Text_Placeholder) : EColor.borderColor(EColor.BGColor_1)
        color: "white"
    }
    Rectangle{
        width: parent.height-1
        height: parent.height-2
        color: EColor.bgColor(EColor.BGColor_2)
        anchors.left: parent.left
        anchors.top: parent.top
        radius: 4
        anchors.margins: 1
        Rectangle{
            height:parent.height
            width: 1
            anchors.right: parent.right
            color: EColor.borderColor(EColor.Border_1)
        }

        Text {
            id: donwIcon
            text:"\uf86c"
            anchors.fill: parent
            font.pixelSize: 14
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.family: EFont.iconRegular
            color: downMouseArea.containsMouse?EColor.mainColor(EColor.MColor_1) :EColor.textColor(EColor.Text_Placeholder)
            MouseArea{
                id:downMouseArea
                property bool downhovered: false
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    downValuefun()
                }
                onPressAndHold: {
                    downHoldDelyTimer.start()
                }
                onReleased: {
                    downHoldDelyTimer.stop()
                }
            }
        }
    }
    TextField{
        id:spinInput
        width: parent.width-parent.height*2
        anchors.centerIn: parent
        height: parent.height
        font.pixelSize: 14
        font.family: EFont.textHanSansNormal
        background: Rectangle {
            width: parent.width
            height: parent.height-2
            anchors.verticalCenter: parent.verticalCenter
            color: rootSpinbox.enabled? "white": EColor.bgColor(EColor.BGColor_2)
        }
        text: cusValue.toString()
        validator:IntValidator{bottom: cusMinValue; top: cusMaxValue;}
        horizontalAlignment: TextField.AlignHCenter
        onEditingFinished: {
            text =  Number(spinInput.text).toString()
            cusValue =  Number(spinInput.text)
        }
        color:rootSpinbox.enabled? EColor.textColor(EColor.Text_Routine) : EColor.textColor(EColor.Text_Placeholder)
    }
    Rectangle{
        width: parent.height-1
        height: parent.height-2
        color: EColor.bgColor(EColor.BGColor_2)
        anchors.right: parent.right
        anchors.top: parent.top
        radius: 4
        anchors.margins: 1
        Rectangle{
            height:parent.height
            width: 1
            anchors.left: parent.left
            color: EColor.borderColor(EColor.Border_1)
        }
        Text {
            id: upIcon
            text:"\uf067"
            anchors.fill: parent
            font.pixelSize: 14
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.family: EFont.iconRegular
            color:upMouseArea.containsMouse?EColor.mainColor(EColor.MColor_1) : EColor.textColor(EColor.Text_Placeholder)
            MouseArea{
                id:upMouseArea
                anchors.fill: parent
                hoverEnabled: true
                property bool uphovered: false
                onClicked: {
                    upValuefun()
                }
                onPressAndHold: {
                    upHoldDelyTimer.start()
                }
                onReleased: {
                    upHoldDelyTimer.stop()
                }
            }
        }
    }

    Timer{
        id:downHoldDelyTimer
        repeat: true
        interval: 200
        triggeredOnStart:true
        onTriggered: {
            if(downMouseArea.pressed)
                downValuefun()
            if(cusValue <= cusMinValue)
                stop()
        }
    }

    Timer{
        id:upHoldDelyTimer
        repeat: true
        interval: 200
        triggeredOnStart:true
        onTriggered: {
            if(upMouseArea.pressed)
                upValuefun()
            if(cusValue >= cusMaxValue)
                stop()
        }
    }

    onCusValueChanged: {
        if(cusValue > cusMaxValue ){
            cusValue = cusMaxValue
            return
        }
        if(cusValue < cusMinValue){
            cusValue = cusMinValue
            return
        }
        spinInput.text = cusValue.toString()
    }

    function downValuefun(){
        var nowvalue = Number(spinInput.text)
        if(nowvalue-cusStep >= cusMinValue)
            cusValue =nowvalue-cusStep
        else
            cusValue = cusMinValue
    }
    function upValuefun(){
        var nowvalue = Number(spinInput.text)
        if(nowvalue+cusStep <= cusMaxValue)
            cusValue = nowvalue+cusStep
        else
            cusValue = cusMaxValue
    }
}
