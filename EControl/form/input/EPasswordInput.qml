import QtQuick 2.0
import QtQuick.Controls 2.5

import EUIpackage 1.0

TextField {
    id:rootInput

    property bool cusIsError: false
    echoMode:TextInput.Password
    width: 180
    height: 40
    placeholderText:"请输入密码"
    passwordCharacter:"•"
    selectionColor: EColor.mainColor(EColor.MColor_1)
    placeholderTextColor:EColor.textColor(EColor.Text_Placeholder)
    font.pixelSize:14
    selectByMouse:true
    font.family: EFont.textHanSansNormal
    color:enabled? EColor.textColor(EColor.Text_Routine) :EColor.textColor(EColor.Text_Placeholder)
    background: Rectangle{
        anchors.fill: parent
        radius: 4
        border.width: 1
        color:rootInput.enabled? "white": EColor.bgColor(EColor.BGColor_2)
        border.color:cusIsError? EColor.stateColor(EColor.Danger_0) :  rootInput.focus? EColor.mainColor(EColor.MColor_1):
                rootInput.hovered? EColor.textColor(EColor.Text_Placeholder) : EColor.borderColor(EColor.Border_1)
    }
    onTextChanged: {
        if(text.length ===0){
            cusIsError = false
        }
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
            text:"\uf06e"
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
            property bool currShowPasswordState: false
            onClicked: {
                if(currShowPasswordState){
                    rootInput.echoMode = TextInput.Password

                }
                else{
                    rootInput.echoMode = TextInput.Normal
                }
                currShowPasswordState = !currShowPasswordState
            }
        }
    }
}
