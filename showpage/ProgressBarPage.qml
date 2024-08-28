import QtQuick 2.0

import EUIpackage 1.0
import EControl 1.0

Rectangle {
    color: EColor.bgColor(EColor.BGColor_2)

    property int minvalue: 0
    property int maxvalue: 100
    property int currvalue: 0
    Text {
        id:title1
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: 8
        text: qsTr("基础进度条")
        width: contentWidth
        height: contentHeight
        font.pixelSize: 20
        color: EColor.mainColor(EColor.MColor_1)
        font.family: EFont.textHanSansNormal
        Timer{
            running: true
            repeat: true
            interval: 300
            onTriggered: {
                if(currvalue !==maxvalue && currvalue+2> maxvalue){
                    currvalue = maxvalue
                }
                else if(currvalue ===maxvalue){
                    currvalue = minvalue
                }
                else
                    currvalue +=2
            }
        }
    }
    Row{
        id:firstRow
        height: 40
        anchors.left: parent.left
        anchors.top: title1.bottom
        anchors.margins: 8
        spacing: 8
        EBaseProgressBar{
            from: minvalue
            to:maxvalue
            value: currvalue
        }
        EBaseProgressBar{
            from: minvalue
            to:maxvalue
            value: currvalue
            cusColor: EColor.stateColor(EColor.Success_0)
        }
        EBaseProgressBar{
            from: minvalue
            to:maxvalue
            value: currvalue
            cusColor: EColor.stateColor(EColor.Info_0)
        }
        EBaseProgressBar{
            from: minvalue
            to:maxvalue
            value: currvalue
            cusColor: EColor.stateColor(EColor.Warning_0)
        }
        EBaseProgressBar{
            from: minvalue
            to:maxvalue
            value: currvalue
            cusColor: EColor.stateColor(EColor.Danger_0)
        }
    }


    Text {
        id:title2
        anchors.left: parent.left
        anchors.top: firstRow.bottom
        anchors.margins: 8
        text: qsTr("内含文字进度条")
        width: contentWidth
        height: contentHeight
        font.pixelSize: 20
        color: EColor.mainColor(EColor.MColor_1)
        font.family: EFont.textHanSansNormal
    }
    Row{
        id:secendRow
        height: 40
        anchors.left: parent.left
        anchors.top: title2.bottom
        anchors.margins: 8
        spacing: 8
        ETextProgressBar{
            from: minvalue
            to:maxvalue
            value: currvalue
        }
        ETextProgressBar{
            from: minvalue
            to:maxvalue
            value: currvalue
            cusColor: EColor.stateColor(EColor.Success_0)
        }
        ETextProgressBar{
            from: minvalue
            to:maxvalue
            value: currvalue
            cusColor: EColor.stateColor(EColor.Info_0)
        }
        ETextProgressBar{
            from: minvalue
            to:maxvalue
            value: currvalue
            cusColor: EColor.stateColor(EColor.Warning_0)
        }
        ETextProgressBar{
            from: minvalue
            to:maxvalue
            value: currvalue
            cusColor: EColor.stateColor(EColor.Danger_0)
        }
    }

    Text {
        id:title3
        anchors.left: parent.left
        anchors.top: secendRow.bottom
        anchors.margins: 8
        text: qsTr("圆形进度条")
        width: contentWidth
        height: contentHeight
        font.pixelSize: 20
        color: EColor.mainColor(EColor.MColor_1)
        font.family: EFont.textHanSansNormal
    }
    Row{
        id:thirdRow
        height: 150
        anchors.left: parent.left
        anchors.top: title3.bottom
        anchors.margins: 8
        spacing: 8
        ERoundProgressBar{
            from: minvalue
            to:maxvalue
            value: currvalue
        }
        ERoundProgressBar{
            from: minvalue
            to:maxvalue
            value: currvalue
            cusColor: EColor.stateColor(EColor.Success_0)
        }
        ERoundProgressBar{
            from: minvalue
            to:maxvalue
            value: currvalue
            cusColor: EColor.stateColor(EColor.Info_0)
        }
        ERoundProgressBar{
            from: minvalue
            to:maxvalue
            value: currvalue
            cusColor: EColor.stateColor(EColor.Warning_0)
        }
        ERoundProgressBar{
            from: minvalue
            to:maxvalue
            value: currvalue
            cusColor: EColor.stateColor(EColor.Danger_0)
        }
    }

    Text {
        id:title4
        anchors.left: parent.left
        anchors.top: thirdRow.bottom
        anchors.margins: 8
        text: qsTr("仪表盘进度条")
        width: contentWidth
        height: contentHeight
        font.pixelSize: 20
        color: EColor.mainColor(EColor.MColor_1)
        font.family: EFont.textHanSansNormal
    }
    Row{
        height: 150
        anchors.left: parent.left
        anchors.top: title4.bottom
        anchors.margins: 8
        spacing: 8
        EDashboardPrgBar{
            from: minvalue
            to:maxvalue
            value: currvalue
        }
        EDashboardPrgBar{
            from: minvalue
            to:maxvalue
            value: currvalue
            cusColor: EColor.stateColor(EColor.Success_0)
        }
        EDashboardPrgBar{
            from: minvalue
            to:maxvalue
            value: currvalue
            cusColor: EColor.stateColor(EColor.Info_0)
        }
        EDashboardPrgBar{
            from: minvalue
            to:maxvalue
            value: currvalue
            cusColor: EColor.stateColor(EColor.Warning_0)
        }
        EDashboardPrgBar{
            from: minvalue
            to:maxvalue
            value: currvalue
            cusColor: EColor.stateColor(EColor.Danger_0)
        }
    }
}
