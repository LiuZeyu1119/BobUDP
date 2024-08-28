import QtQuick 2.0

import EUIpackage 1.0
import EControl 1.0
Rectangle {
    color: EColor.mainColor(EColor.MColor_9)

    Text {
        id:title1
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: 8
        text: qsTr("Pagination 分页")
        width: contentWidth
        height: contentHeight
        font.pixelSize: 20
        color: EColor.mainColor(EColor.MColor_1)
        font.family: EFont.textHanSansNormal
    }
    EPagination{
        id:epagination1
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.margins: 8
        cusCount:7
        onCusCurrentPageChanged:{
           console.log("epagination1>>"+cusCurrentPage)
        }
    }
    Text {
        text: epagination1.cusCurrentPage.toString()
        width: contentWidth
        height: contentHeight
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter:epagination1.horizontalCenter
        anchors.leftMargin: 20
        font.pixelSize: 40
        color: EColor.mainColor(EColor.MColor_0)
    }

    EPagination{
        id:epagination2
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.margins: 8
        cusBgVisible:false
        cusCount:16
        onCusCurrentPageChanged:{
           console.log("epagination2>>"+cusCurrentPage)
        }
    }
    Text {
        text: epagination2.cusCurrentPage.toString()
        width: contentWidth
        height: contentHeight
        anchors.centerIn: parent
        font.pixelSize: 40
        color: EColor.mainColor(EColor.MColor_0)
    }


    EPagination{
        id:epagination
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 8
        cusCount:28
        onCusCurrentPageChanged:{
           console.log("CusCurrentPage>>"+cusCurrentPage)
        }
    }

    Text {
        id: currpageText
        text: epagination.cusCurrentPage.toString()
        width: contentWidth
        height: contentHeight
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter:epagination.horizontalCenter
        font.pixelSize: 40
        color: EColor.mainColor(EColor.MColor_0)
    }
}
