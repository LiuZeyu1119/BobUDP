import QtQuick 2.0
import QtQuick.Controls 2.5

import EUIpackage 1.0


Item {
    id: root
    height: cusIndicatorWidth
    width: rowlayout.width
    property int cusIndicatorWidth: 30

    property int cusIndicatorHeight: 30

    property int cusSpacing: 8

    property int cusCurrentIndex: 0

    property int cusCurrentPage: 0

    property int cusCount: 100

    property bool cusBgVisible: true

    property int cusTextSize: 14
    //middle display count
    property int cusMiddleDisplayCount: 5
    //middle start
    property int cusMiddleStartIndex: 1
    //middle step
    property int cusMiddleStep: 5

    readonly property color cusBgColor: EColor.stateColor(EColor.Info_3)
    readonly property color cusSelectedColor: EColor.mainColor(EColor.MColor_1)
    readonly property color cusTextColor: EColor.textColor(EColor.Text_Routine)
    readonly property color cusSelectedTextColor: "#FFFFFF"
    Row {
        id:rowlayout
        property bool initing: false
        height: cusIndicatorHeight
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        spacing: root.cusSpacing
        //left button for last current
        Button {
            id: leftBtn
            width: root.cusIndicatorWidth
            height: root.cusIndicatorHeight
            enabled: root.cusCurrentIndex > 0
            onClicked: {
                if (root.cusCurrentIndex - 1 >= 0) {
                    root.gotoIndex(root.cusCurrentIndex - 1)
                }
            }
            background: Rectangle{
                anchors.fill: parent
                radius: 4
                color: cusBgColor
                visible: cusBgVisible
            }
            contentItem: Text {
                text: "\uf053"
                font.pixelSize: cusTextSize
                font.family:  EFont.iconRegular
                color: enabled ? cusTextColor : EColor.textColor(EColor.Text_Placeholder)
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }
        //start button for first
        Button {
            id: startBtn
            property bool selected: root.cusCurrentIndex === 0
            width: root.cusIndicatorWidth
            height: root.cusIndicatorHeight
            //at last 1 item for begin
            visible: root.cusCount > 0
            onClicked: {
                root.gotoIndex(0)
            }
            background: Rectangle{
                visible: cusBgVisible
                anchors.fill: parent
                radius: 4
                color: startBtn.selected? cusSelectedColor :cusBgColor
            }
            contentItem: Text {
                text: "1"
                font.pixelSize:cusTextSize
                font.family: EFont.textHanSansMedium
                color:{
                    if(enabled){
                        if(startBtn.selected && cusBgVisible)
                            return cusSelectedTextColor
                        else if(startBtn.selected && !cusBgVisible)
                            return  cusSelectedColor
                        else if(startBtn.hovered)
                            return  cusSelectedColor
                        else
                            return cusTextColor
                    }
                    else
                        return  EColor.textColor(EColor.Text_Placeholder)
                }
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }
        //last button for last 5, if need ellipsis
        Button {
            id: lastBtn
            width: root.cusIndicatorWidth
            height: root.cusIndicatorHeight
            hoverEnabled: true
            visible: startBtn.visible && root.cusMiddleStartIndex > 1
            onClicked: {
                root.gotoLast()
            }
            background: Rectangle{
                visible: cusBgVisible
                anchors.fill: parent
                radius: 4
                color:cusBgColor
            }
            contentItem: Text {
                text: lastBtn.hovered ? "\uf100" : "\uf141"
                font.pixelSize:cusTextSize
                font.family:  EFont.iconRegular
                color: lastBtn.hovered ? cusSelectedColor : cusTextColor
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }
        // middle
        Repeater {
            id: generater
            enabled: root.cusCount - 2 > 0
            model: Math.min(root.cusMiddleDisplayCount, root.cusCount - 2)
            delegate: Button {
                id:m_but
                property bool selected: root.cusCurrentIndex === root.cusMiddleStartIndex + index
                implicitWidth: root.cusIndicatorWidth
                implicitHeight: root.cusIndicatorHeight
                onClicked: {
                    root.gotoIndex(root.cusMiddleStartIndex + index)
                }
                background: Rectangle{
                    visible: cusBgVisible
                    anchors.fill: parent
                    radius: 4
                    color: m_but.selected? cusSelectedColor : cusBgColor
                }
                contentItem: Text {
                    text: root.cusMiddleStartIndex + index + 1
                    font.pixelSize:cusTextSize
                    font.family: EFont.textHanSansMedium
                    color:{
                        if(enabled){
                            if(m_but.selected && cusBgVisible)
                                return cusSelectedTextColor
                            else if(m_but.selected && !cusBgVisible)
                                return  cusSelectedColor
                            else if(m_but.hovered)
                                return  cusSelectedColor
                            else
                                return cusTextColor
                        }
                        else
                            return  EColor.textColor(EColor.Text_Placeholder)
                    }
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
        }
        //next button for next 5, if need ellipsis
        Button {
            id: nextBtn
            width: root.cusIndicatorWidth
            height: root.cusIndicatorHeight
            hoverEnabled: true
            visible: root.cusCount > 2 && ((root.cusCount - 1) - (root.cusMiddleStartIndex + generater.count) >= 1)
            onClicked: {
                root.gotoNext()
            }
            background: Rectangle{
                visible: cusBgVisible
                anchors.fill: parent
                radius: 4
                color:cusBgColor
            }
            contentItem: Text {
                text: nextBtn.hovered ? "\uf101" : "\uf141"
                font.pixelSize:cusTextSize
                font.family: EFont.iconRegular
                color: nextBtn.hovered ? cusSelectedColor : cusTextColor
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }
        //end button for end one
        Button {
            id: endBtn
            property bool selected: root.cusCurrentIndex === root.cusCount - 1
            width: root.cusIndicatorWidth
            height: root.cusIndicatorHeight
            font.pixelSize:cusTextSize
            //at last 2 item, one for begin, one for end
            visible: root.cusCount > 1
            onClicked: {
                root.gotoIndex(root.cusCount - 1)
            }
            background: Rectangle{
                visible: cusBgVisible
                anchors.fill: parent
                radius: 4
                color: endBtn.selected?cusSelectedColor :cusBgColor
            }
            contentItem: Text {
                text: root.cusCount
                font.pixelSize:cusTextSize
                font.family: EFont.textHanSansMedium
                color:{
                    if(enabled){
                        if(endBtn.selected && cusBgVisible)
                            return cusSelectedTextColor
                        else if(endBtn.selected && !cusBgVisible)
                            return  cusSelectedColor
                        else if(endBtn.hovered)
                            return  cusSelectedColor
                        else
                            return cusTextColor
                    }
                    else
                        return  EColor.textColor(EColor.Text_Placeholder)
                }
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }
        //next one for next current
        Button {
            id: rightBtn
            width: root.cusIndicatorWidth
            height: root.cusIndicatorHeight
            onClicked: {
                if (root.cusCurrentIndex + 1 < root.cusCount) {
                    root.gotoIndex(root.cusCurrentIndex + 1)
                }
            }
            enabled: root.cusCurrentIndex < root.cusCount - 1
            background: Rectangle{
                visible: cusBgVisible
                anchors.fill: parent
                radius: 4
                color: cusBgColor
            }
            contentItem: Text {
                text: "\uf054"
                font.pixelSize: cusTextSize
                font.family: EFont.iconRegular
                color: enabled ? cusTextColor : EColor.textColor(EColor.Text_Placeholder)
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }
    }
    function gotoLast() {
        var t = root.cusCurrentIndex - cusMiddleStep
        if (t < 0) {
            t = 0
        }
        gotoIndex(t)
    }
    function gotoNext() {
        var t = root.cusCurrentIndex + cusMiddleStep
        if (t > root.cusCount - 1) {
            t = root.cusCount - 1
        }
        gotoIndex(t)
    }
    function gotoIndex(targetIndex) {
        if (targetIndex < 0 || targetIndex >= root.cusCount) {
            return
        }
        if (targetIndex === root.cusCurrentIndex) {
            return
        }
        root.cusCurrentIndex = targetIndex
    }
    onCusCurrentIndexChanged: {
        updateMiddle()
        if(!rowlayout.initing){
            cusCurrentPage = cusCurrentIndex+1
        }
    }
    Component.onCompleted: {
        updateMiddle()
    }
    function updateMiddle() {
        if (root.cusCount - 2 <= root.cusMiddleDisplayCount) {
            root.cusMiddleStartIndex = 1
        } else {
            var minV = 1
            var maxV = root.cusCount - root.cusMiddleDisplayCount - 1
            var half = parseInt(generater.count / 2)
            var midV = root.cusCurrentIndex - half
            root.cusMiddleStartIndex = bound(minV, midV, maxV)
        }
    }
    function bound(minValue, midValue, maxValue) {
        return Math.max(minValue, Math.min(midValue, maxValue))
    }
    function initPage(allPageCount){
        rowlayout.initing = true
        cusCurrentIndex = 0
        count = allPageCount
        rowlayout.initing = false
    }
}
