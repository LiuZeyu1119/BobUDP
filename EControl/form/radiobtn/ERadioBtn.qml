import QtQuick 2.0
import QtQuick.Controls 2.5

import EUIpackage 1.0

RadioButton {
    id:rootRadioBtn
    text: qsTr("First")
    implicitWidth: 100
    implicitHeight: 40

    property color cusChcekedColor: EColor.mainColor(EColor.MColor_1)
    property color cusUnChcekedColor:EColor.textColor(EColor.Text_Routine)
    property int cusIconSize:16
    property bool cusIsBorderBtn: false

    background: Rectangle{
        visible:cusIsBorderBtn
        anchors.fill: parent
        border.width: 1
        border.color: getColor()
        radius: 4
        color: "transparent"
    }

    indicator:Text {
        id: iconText
        text: rootRadioBtn.checked?  "\uf2f8" :"\uf111"
        font.pixelSize: cusIconSize
        width: contentWidth
        height: contentHeight
        anchors.left: parent.left
        anchors.leftMargin: rootRadioBtn.cusIsBorderBtn? 10:0
        anchors.verticalCenter: parent.verticalCenter
        font.family: rootRadioBtn.checked? EFont.iconSolid: EFont.iconRegular
        color: getColor()
    }


    contentItem: Text {
        id: contenText
        anchors.left:iconText.right
        anchors.leftMargin:8
        anchors.right: parent.right
        elide: Text.ElideRight
        height: contentHeight
        anchors.verticalCenter: parent.verticalCenter
        text: rootRadioBtn.text
        font.family: EFont.textHanSansNormal
        color: getColor()
        font.pixelSize: cusIconSize+2
    }

    function getColor(){
        if(!enabled)
            return EColor.textColor(EColor.Text_Placeholder)
        else if(rootRadioBtn.checked)
            return cusChcekedColor
        else if(rootRadioBtn.hovered)
            return cusChcekedColor
        else
            return cusUnChcekedColor

    }
}
