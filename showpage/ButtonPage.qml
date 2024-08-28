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
        text: qsTr("基础按钮")
        width: contentWidth
        height: contentHeight
        font.pixelSize: 20
        color: EColor.mainColor(EColor.MColor_1)
        font.family: EFont.textHanSansNormal
    }
    Row{
        id:firstRow
        anchors.left: parent.left
        anchors.top: title1.bottom
        anchors.topMargin: 10
        anchors.leftMargin: 10
        height: defaultBtn.height
        spacing: 16
        EBaseBtn{
            id:defaultBtn
            cusText: "默认按钮"
        }
        EMainBtn{
            id:mainBtn
            cusText: "主要按钮"
        }
        ESuccessBtn{
            id:successBtn
            cusText: "成功按钮"
        }
        EInfoBtn{
            id:infoBtn
            cusText: "信息按钮"
        }
        EWarningBtn{
            id:warningBtn
            cusText: "警告按钮"
        }
        EDangerBtn{
            id:dangerBtn
            cusText: "危险按钮"
        }
    }

    Row{
        id:secendRow
        anchors.left: parent.left
        anchors.top: firstRow.bottom
        anchors.topMargin: 20
        anchors.leftMargin: 10
        height: 50
        spacing: 16
        EBaseBtn{
            cusText: "默认按钮"
            enabled: false
        }
        EMainBtn{
            cusText: "主要按钮"
            enabled: false
        }
        ESuccessBtn{
            cusText: "成功按钮"
            enabled: false
        }
        EInfoBtn{
            cusText: "信息按钮"
            enabled: false
        }
        EWarningBtn{
            cusText: "警告按钮"
            enabled: false
        }
        EDangerBtn{
            cusText: "危险按钮"
            enabled: false
        }
    }

    Row{
        id:thirdRow
        anchors.left: parent.left
        anchors.top: secendRow.bottom
        anchors.topMargin: 20
        anchors.leftMargin: 10
        height: defaultBtn.height
        spacing: 16
        EBaseBtn{
            cusText: "朴素按钮"
            cusStyle: EBaseBtn.BtnStyle.Simple
        }
        EMainBtn{
            cusText: "主要按钮"
            cusStyle: EMainBtn.BtnStyle.Simple
        }
        ESuccessBtn{
            cusText: "成功按钮"
            cusStyle: ESuccessBtn.BtnStyle.Simple
        }
        EInfoBtn{
            cusText: "信息按钮"
            cusStyle: EInfoBtn.BtnStyle.Simple
        }
        EWarningBtn{
            cusText: "警告按钮"
            cusStyle: EWarningBtn.BtnStyle.Simple
        }
        EDangerBtn{
            cusText: "危险按钮"
            cusStyle: EDangerBtn.BtnStyle.Simple
        }
    }

    Row{
        id:fourthRow
        anchors.left: parent.left
        anchors.top: thirdRow.bottom
        anchors.topMargin: 20
        anchors.leftMargin: 10
        height: defaultBtn.height
        spacing: 16

        EBaseBtn{
            cusText: "朴素按钮"
            cusStyle: EBaseBtn.BtnStyle.Simple
            enabled: false
        }
        EMainBtn{
            cusText: "主要按钮"
            cusStyle: EMainBtn.BtnStyle.Simple
            enabled: false
        }
        ESuccessBtn{
            cusText: "成功按钮"
            cusStyle: ESuccessBtn.BtnStyle.Simple
            enabled: false
        }
        EInfoBtn{
            cusText: "信息按钮"
            cusStyle: EInfoBtn.BtnStyle.Simple
            enabled: false
        }
        EWarningBtn{
            cusText: "警告按钮"
            cusStyle: EWarningBtn.BtnStyle.Simple
            enabled: false
        }
        EDangerBtn{
            cusText: "危险按钮"
            cusStyle: EDangerBtn.BtnStyle.Simple
            enabled: false
        }
    }

    Text {
        id:title2
        anchors.left: parent.left
        anchors.top: fourthRow.bottom
        anchors.margins: 10
        text: qsTr("图标按钮")
        width: contentWidth
        height: contentHeight
        font.pixelSize: 20
        color: EColor.mainColor(EColor.MColor_1)
        font.family: EFont.textHanSansNormal
    }
    Row{
        id:fifthRow
        anchors.left: parent.left
        anchors.top: title2.bottom
        anchors.topMargin: 20
        anchors.leftMargin: 10
        height: defaultBtn.height
        spacing: 16
        EIconBaseBtn{
            cusIcon: "\uf002"
        }
        EIconBaseBtn{
            cusIcon: "\uf002"
            cusStyle: EIconBaseBtn.BtnStyle.Simple
        }
        EIconMainBtn{
            cusIcon: "\uf044"
        }
        EIconMainBtn{
            cusIcon: "\uf044"
            cusStyle: EIconMainBtn.BtnStyle.Simple
        }
        EIconSuccessBtn{
            cusIcon: "\uf00c"
        }
        EIconInfoBtn{
            cusIcon: "\uf00c"
            cusStyle: EIconSuccessBtn.BtnStyle.Simple
        }
        EIconInfoBtn{
            cusIcon: "\uf0e0"
        }
        EIconInfoBtn{
            cusIcon: "\uf0e0"
            cusStyle: EIconInfoBtn.BtnStyle.Simple
        }
        EIconWarningBtn{
            cusIcon: "\uf005"
        }
        EIconWarningBtn{
            cusIcon: "\uf005"
            cusStyle: EIconInfoBtn.BtnStyle.Simple
        }
        EIconDangerBtn{
            cusIcon: "\uf2ed"
        }
        EIconDangerBtn{
            cusIcon: "\uf2ed"
            cusStyle: EIconInfoBtn.BtnStyle.Simple
        }
    }

    Text {
        id:title3
        anchors.left: parent.left
        anchors.top: fifthRow.bottom
        anchors.margins: 10
        text: qsTr("图标加文字按钮")
        width: contentWidth
        height: contentHeight
        font.pixelSize: 20
        color: EColor.mainColor(EColor.MColor_1)
        font.family: EFont.textHanSansNormal
    }
    Row{
        id:sixthRow
        anchors.left: parent.left
        anchors.top: title3.bottom
        anchors.topMargin: 20
        anchors.leftMargin: 10
        height: defaultBtn.height
        spacing: 16

        EIconBtn{
            cusText: ""
            cusIcon: "\uf044"
        }
        EIconBtn{
            cusText: "编辑"
            cusIcon: "\uf044"
        }
        ELoadingBtn{
            cusText: "编辑"
            cusIcon: "\uf044"
            onClicked: {
                cusIsLoading =true
                stopLoading.start()
            }
            Timer{
                id:stopLoading
                interval: 3000
                onTriggered: {
                    parent.cusIsLoading = false
                }
            }
        }
    }
}
