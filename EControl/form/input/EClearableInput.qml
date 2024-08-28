import QtQuick 2.0
import QtQuick.Controls 2.5

import EUIpackage 1.0

TextField {
    id:rootInput
    width: 180
    height: 40
    placeholderText:"请输入内容"
    selectByMouse:true
    selectionColor: EColor.mainColor(EColor.MColor_1)
    placeholderTextColor:EColor.textColor(EColor.Text_Placeholder)
    font.pixelSize:14
    font.family: EFont.textHanSansNormal
    color:enabled? EColor.textColor(EColor.Text_Routine) :EColor.textColor(EColor.Text_Placeholder)
    background: Rectangle{
        anchors.fill: parent
        radius: 4
        border.width: 1
        color:rootInput.enabled? "white": EColor.bgColor(EColor.BGColor_2)
        border.color:rootInput.focus? EColor.mainColor(EColor.MColor_1):
                rootInput.hovered? EColor.textColor(EColor.Text_Placeholder) : EColor.borderColor(EColor.Border_1)

    }
    Rectangle{
        width: clearIcn.width+16
        height: parent.height-2
        anchors.verticalCenter: parent.verticalCenter
        radius: 4
        anchors.right: parent.right
        anchors.rightMargin: 1
        color:rootInput.enabled? "white": EColor.bgColor(EColor.BGColor_2)
        Text {
            id: clearIcn
            text:"\uf057"
            visible: rootInput.length > 0
            width: contentWidth
            height: contentHeight
            font.pixelSize: rootInput.font.pixelSize
            anchors.centerIn: parent
            font.family: EFont.iconRegular
            anchors.verticalCenter: parent.verticalCenter
            color: EColor.textColor(EColor.Text_Placeholder)
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                rootInput.clear()
            }
        }
    }
}
