import QtQuick 2.0

import EUIpackage 1.0
import EControl 1.0

Rectangle {
    color: EColor.bgColor(EColor.BGColor_1)


    Text {
        id:title1
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: 10
        text: qsTr("Notice 相关控件")
        width: contentWidth
        height: contentHeight
        font.pixelSize: 20
        color: EColor.mainColor(EColor.MColor_1)
        font.family: EFont.textHanSansNormal
    }
    Column{
        id:firstRow
        anchors.left: parent.left
        anchors.top: title1.bottom
        anchors.topMargin: 10
        anchors.leftMargin: 10
        width: 200
        spacing: 16
        EBaseBtn{
            id:openLoadBtn
            cusText: "显示Loading"
            onClicked: {
                loading1.visible =true
                loading1.cusIsRotation = true
            }
        }
        EBaseBtn{
            id:closLoadBtn
            cusText: "关闭Loading"
            onClicked: {
                loading1.cusIsRotation = false
                loading1.visible =false
            }
        }
        EMainBtn{
            cusText: "自定义Toast"
            onClicked: {
                mytoast.setCusColor(EColor.stateColor(EColor.Warning_2),EColor.stateColor(EColor.Danger_0),"\uf4c7")
                mytoast.showToast("这是一段信息，toast样式自定义",EToast.StyleEnum.CUSTOMSTYLE,3000)
            }
        }

        ESuccessBtn{
            id:successBtn
            cusText: "成功Toast"
            onClicked: {
                mytoast.showToast("这是成功信息",EToast.StyleEnum.SUCCESS,3000)
            }
        }
        EInfoBtn{
            id:infoBtn
            cusText: "信息Toast"
            onClicked: {
                mytoast.showToast("这是提示信息",EToast.StyleEnum.INFO,3000)
            }
        }
        EWarningBtn{
            id:warningBtn
            cusText: "警告Toast"
            onClicked: {
                mytoast.showToast("这是一个警告",EToast.StyleEnum.WARNING,3000)
            }
        }
        EDangerBtn{
            id:dangerBtn
            cusText: "错误Toast"
            onClicked: {
                mytoast.showToast("这是错误信息",EToast.StyleEnum.ERROR,3000)
            }
        }

        ESuccessBtn{
            width: 140
            cusText: "成功Toast停留"
            cusStyle: ESuccessBtn.BtnStyle.Simple
            onClicked: {
                mytoast.showToast("停留的成功信息",EToast.StyleEnum.SUCCESS,3000,false)
            }
        }
        EInfoBtn{
            width: 140
            cusText: "信息Toast停留"
            cusStyle: EInfoBtn.BtnStyle.Simple
            onClicked: {
                mytoast.showToast("停留的提示信息",EToast.StyleEnum.INFO,3000,false)
            }
        }
        EWarningBtn{
            width: 140
            cusText: "警告Toast停留"
            cusStyle: EWarningBtn.BtnStyle.Simple
            onClicked: {
                mytoast.showToast("停留的警告信息",EToast.StyleEnum.WARNING,3000,false)
            }
        }
        EDangerBtn{
            width: 140
            cusText: "错误Toast停留"
            cusStyle: EDangerBtn.BtnStyle.Simple
            onClicked: {
                mytoast.showToast("停留的错误信息",EToast.StyleEnum.ERROR,3000,false)
            }
        }
    }
    ELoading{
        id:loading1
        cusLoadingSize: 80
        anchors.centerIn: parent
        cusIsRotation: false
        visible: false
    }
    EToast{
        id:mytoast
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
    }
}
