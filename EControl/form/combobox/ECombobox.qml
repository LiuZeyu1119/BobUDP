import QtQuick 2.12
import QtQuick.Controls 2.5

import EUIpackage 1.0

ComboBox{
    id:rootCbx
    width: 200
    height: 40
    onDownChanged: {
        if(down){
            expandAni.start()
        }
        else{
            collapseAni.start()
        }
    }

    background: Rectangle{
        anchors.fill: parent
        radius: 4
        border.width: 1
        color:rootCbx.enabled? "white": EColor.bgColor(EColor.BGColor_2)
        border.color:rootCbx.focus? EColor.mainColor(EColor.MColor_1):
                rootCbx.hovered? EColor.textColor(EColor.Text_Placeholder) : EColor.borderColor(EColor.Border_1)
    }

    contentItem: Item {
        anchors.left: parent.left
        anchors.leftMargin: 10
        height: parent.height
        anchors.right: indicatorText.left
        anchors.rightMargin: 6
        Text{
            text: rootCbx.currentText
            anchors.fill: parent
            verticalAlignment: Text.AlignVCenter
            color: rootCbx.enabled? EColor.textColor(EColor.Text_Routine) :EColor.textColor(EColor.Text_Placeholder)
            font.pixelSize:14
            font.family: EFont.textHanSansMedium
            elide: Text.ElideRight
        }
    }
    indicator:Text{//指示图标
        id:indicatorText
        anchors.right: parent.right
        anchors.rightMargin: 16
        anchors.verticalCenter: parent.verticalCenter
        color: EColor.borderColor(EColor.Border_1)
        font.family: EFont.iconRegular
        font.pixelSize: 16
        width: contentWidth
        height: contentHeight
        text: "\uf107"
        RotationAnimation{
            id:expandAni
            target: indicatorText
            to:-180
            duration: 100
        }
        RotationAnimation{
            id:collapseAni
            target: indicatorText
            to:0
            duration: 100
        }
    }
    popup: Popup{
        id:cusPopup
        y:parent.height+4
        width: parent.width
        height: dataListview.count >= 5? (parent.height*5+2) : (parent.height*dataListview.count+2)
        background: Rectangle {
            anchors.fill: parent
            radius: 4
            border.width: 1
            border.color: EColor.borderColor(EColor.Border_1)
        }
        contentItem: ListView{
            id:dataListview
            anchors.fill: parent
            anchors.margins: 1
            clip: true
            model: rootCbx.model
            delegate: ItemDelegate{
                width: parent.width
                height: 40
                contentItem: Text {
                    id:dataText
                    text: rootCbx.textRole === "" ? modelData : rootCbx.model.get(index)[rootCbx.textRole]
                    width: parent.width-20
                    height: parent.height
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    verticalAlignment: Text.AlignVCenter
                    color:dataListview.currentIndex === index? EColor.mainColor(EColor.MColor_1) : EColor.textColor(EColor.Text_Routine)
                    font.pixelSize:14
                    font.family: EFont.textHanSansMedium
                    elide: Text.ElideRight
                }

                background: Rectangle{
                    anchors.fill: parent
                    radius: 4
                    color: hovered? EColor.bgColor(EColor.BGColor_2): "white"
                }
                onClicked: {
                    dataListview.currentIndex = index
                    rootCbx.currentIndex = index
                    cusPopup.visible = false
                }
            }
        }
    }
}
