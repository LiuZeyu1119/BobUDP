import QtQuick 2.12
import QtQuick.Controls 2.12

import EUIpackage 1.0


Switch {
    id: rootSwitch
    text: qsTr("Switch")
    width: 40
    height: width/2
    property color cusCheckedColor: EColor.mainColor(EColor.MColor_1)
    property color cusUnCheckedColor: EColor.borderColor(EColor.Border_1)
    indicator: Rectangle {
        anchors.fill: parent
        radius: height / 2
        color: rootSwitch.checked ? cusCheckedColor : cusUnCheckedColor
        border.color: rootSwitch.checked ? cusCheckedColor : cusUnCheckedColor

        Rectangle {
            x: rootSwitch.checked ? parent.width - width-1 : 1
            width: parent.height-2
            height: parent.height-2
            radius: height/2
            anchors.verticalCenter: parent.verticalCenter
            color: rootSwitch.down ? EColor.bgColor(EColor.BGColor_2) : "white"
            border.color: rootSwitch.checked ? cusCheckedColor : cusUnCheckedColor
            Behavior on x {
                NumberAnimation { duration: 100 }
            }
        }
        Rectangle{
            color: EColor.bgColor(EColor.BGColor_2)
            opacity: 0.5
            visible: !rootSwitch.enabled
            anchors.fill: parent
        }
    }

}
