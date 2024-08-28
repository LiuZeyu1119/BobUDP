import QtQuick 2.12
import QtQuick.Controls 2.12

import EUIpackage 1.0

Rectangle {
    property int cusLoadingSize: 40                     //图标大小
    property color cusLoadingColor: EColor.mainColor(EColor.MColor_1)
    property bool cusIsRotation: true                   //是否旋转
    property int cusLoadDuration: 1500                  //默认1.5秒一圈
    property int easingType: Easing.Linear              //动画曲线默认为第1种
    property color cusBgColor: "transparent"
    id:loading
    implicitHeight: loadicon.height
    implicitWidth: loadicon.width
    color:cusBgColor
    Text {
        id:loadicon
        anchors.centerIn: parent
        color: cusLoadingColor
        text: "\uf3f4"
        font.pixelSize: cusLoadingSize
        font.family:  EFont.iconRegular
        RotationAnimation on rotation {
            from: 0
            to: 360
            duration: cusLoadDuration
            loops: Animation.Infinite           //重复次数
            easing.type: easingType
            running: cusIsRotation
        }
    }
}
