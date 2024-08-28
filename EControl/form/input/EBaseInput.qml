import QtQuick 2.12
import QtQuick.Controls 2.5

import EUIpackage 1.0

TextField {
    id:rootInput
    width: 180
    height: 40
    placeholderText:"请输入内容"
    placeholderTextColor:EColor.textColor(EColor.Text_Placeholder)
    font.pixelSize:14
    color: EColor.textColor(EColor.Text_Routine)
    selectByMouse:true
    selectionColor: EColor.mainColor(EColor.MColor_1)
    font.family: EFont.textHanSansMedium
    background: Rectangle{
        anchors.fill: parent
        radius: 4
        border.width: 1
        color:rootInput.enabled? "white": EColor.bgColor(EColor.BGColor_2)
        border.color:rootInput.focus? EColor.mainColor(EColor.MColor_1):
                rootInput.hovered? EColor.textColor(EColor.Text_Placeholder) : EColor.borderColor(EColor.Border_1)
    }
}
