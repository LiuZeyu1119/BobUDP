import QtQuick 2.0

import EUIpackage 1.0
import EControl 1.0
Rectangle {
    color: EColor.bgColor(EColor.BGColor_1)
    Text {
        id: mainColorText
        text: qsTr("主色(双击色块复制颜色)")
        width:contentWidth
        height: contentHeight
        anchors.left:parent.left
        anchors.leftMargin: 8
        color: EColor.mainColor(EColor.MColor_1)
        font.pixelSize: 28
    }
    Item{
        id:maincolorArea
        width: 380
        height: 180
        anchors.left:parent.left
        anchors.leftMargin: 8
        anchors.top: mainColorText.bottom
        anchors.topMargin: 4
        clip: true
        ColorCopyRet{
            id:mainRet
            width: parent.width
            height: parent.height/5*3
            color: EColor.mainColor(EColor.MColor_0)
            onSigCopyColorSuccess: {
                mytoast.showToast("复制 "+colorName+" 成功",EToast.StyleEnum.SUCCESS,4000)
            }
        }
        Row{
            anchors.top: mainRet.bottom
            height: parent.height-mainRet.height
            Repeater{
                model:10
                ColorCopyRet{
                    width: mainRet.width/10
                    height: 320-mainRet.height
                    color: getMainColor(index)
                    onSigCopyColorSuccess: {
                        mytoast.showToast("复制 "+colorName+" 成功",EToast.StyleEnum.SUCCESS,4000)
                    }
                }
            }
        }
    }

    Text {
        id: secondaryText
        text: qsTr("辅助色")
        width:contentWidth
        height: contentHeight
        anchors.top: maincolorArea.bottom
        anchors.topMargin: 50
        anchors.left:parent.left
        anchors.leftMargin: 8
        color: EColor.mainColor(EColor.MColor_1)
        font.pixelSize: 28
    }
    ListView{
        id:secondaryColorArea
        width: parent.width-8
        anchors.left: parent.left
        anchors.leftMargin: 8
        anchors.top: secondaryText.bottom
        anchors.topMargin: 4
        height: 160
        orientation:ListView.Horizontal
        model: stateColorModel
        spacing:10
        interactive: false
        delegate: Item {
            id:delItem
            width: 220
            height: parent.height
            ColorCopyRet{
                width: parent.width
                height: parent.height/5*3
                color: EColor.stateColor(color0)
                onSigCopyColorSuccess: {
                    mytoast.showToast("复制 "+colorName+" 成功",EToast.StyleEnum.SUCCESS,4000)
                }
            }
            Row{
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                height: parent.height/5*2
                ColorCopyRet{
                    width: delItem.width/3
                    height: parent.height
                    color: EColor.stateColor(color1)
                    onSigCopyColorSuccess: {
                        mytoast.showToast("复制 "+colorName+" 成功",EToast.StyleEnum.SUCCESS,4000)
                    }
                }
                ColorCopyRet{
                    width: delItem.width/3
                    height: parent.height
                    color: EColor.stateColor(color2)
                    onSigCopyColorSuccess: {
                        mytoast.showToast("复制 "+colorName+" 成功",EToast.StyleEnum.SUCCESS,4000)
                    }
                }
                ColorCopyRet{
                    width: delItem.width/3
                    height: parent.height
                    color: EColor.stateColor(color3)
                    onSigCopyColorSuccess: {
                        mytoast.showToast("复制 "+colorName+" 成功",EToast.StyleEnum.SUCCESS,4000)
                    }
                }
            }
        }
    }
    ListModel{
        id:stateColorModel
        ListElement{
            color0:EColor.Success_0
            color1:EColor.Success_1
            color2:EColor.Success_2
            color3:EColor.Success_3
        }
        ListElement{
            color0:EColor.Warning_0
            color1:EColor.Warning_1
            color2:EColor.Warning_2
            color3:EColor.Warning_3
        }
        ListElement{
            color0:EColor.Danger_0
            color1:EColor.Danger_1
            color2:EColor.Danger_2
            color3:EColor.Danger_3
        }
        ListElement{
            color0:EColor.Info_0
            color1:EColor.Info_1
            color2:EColor.Info_2
            color3:EColor.Info_3
        }
    }


    Text {
        id: neutralText
        text: qsTr("中性色")
        width:contentWidth
        height: contentHeight
        anchors.top: secondaryColorArea.bottom
        anchors.topMargin: 50
        anchors.left:parent.left
        anchors.leftMargin: 8
        color: EColor.mainColor(EColor.MColor_1)
        font.pixelSize: 28
    }
    Row{
        id:textColorRowlayout
        height: 90
        anchors.top: neutralText.bottom
        anchors.topMargin: 4
        anchors.left:parent.left
        anchors.leftMargin: 8
        Repeater{
            model: [EColor.Text_Main,EColor.Text_Routine,EColor.Text_Secondary,EColor.Text_Placeholder]
            ColorCopyRet{
                width: 150
                height: 90
                color: EColor.textColor(modelData)
                onSigCopyColorSuccess: {
                    mytoast.showToast("复制 "+colorName+" 成功",EToast.StyleEnum.SUCCESS,4000)
                }
            }
        }
    }
    Row{
        height: 90
        anchors.top: textColorRowlayout.bottom
        anchors.topMargin: 10
        anchors.left:parent.left
        anchors.leftMargin: 8
        Repeater{
            model: [EColor.Border_1,EColor.Border_2,EColor.Border_3,EColor.Border_4]
            ColorCopyRet{
                width: 150
                height: 90
                color: EColor.borderColor(modelData)
                onSigCopyColorSuccess: {
                    mytoast.showToast("复制 "+colorName+" 成功",EToast.StyleEnum.SUCCESS,4000)
                }
            }
        }
    }
    EToast{
        id:mytoast
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
    }

    function getMainColor(index){
        switch (index){
        case 0:
            return EColor.mainColor(EColor.MColor_1)
        case 1:
            return EColor.mainColor(EColor.MColor_2)
        case 2:
            return EColor.mainColor(EColor.MColor_3)
        case 3:
            return EColor.mainColor(EColor.MColor_4)
        case 4:
            return EColor.mainColor(EColor.MColor_5)
        case 5:
            return EColor.mainColor(EColor.MColor_6)
        case 6:
            return EColor.mainColor(EColor.MColor_7)
        case 7:
            return EColor.mainColor(EColor.MColor_8)
        case 8:
            return EColor.mainColor(EColor.MColor_9)
        case 9:
            return EColor.mainColor(EColor.MColor_10)
        default:
            return EColor.mainColor(EColor.MColor_1)
        }
    }
}
