import QtQuick 2.0
import EUIpackage 1.0

ListView{
    id:expandableListView

    property int currChildIndex: 0
    model:expandableListModel
    delegate: expandableListDelegate
    ListModel{
        id:expandableListModel
    }
    Component{
        id:expandableListDelegate
        Column{
            id:objColumn
            Component.onCompleted: {
                //初始化子节点收起
                for(var i =1;i<objColumn.children.length-1;i++){
                    objColumn.children[i].visible = false
                }
            }

            Rectangle{
                id:parentitem
                width: expandableListView.width
                height: 50
                color: "#334154"
                property bool isExpand: false
                MouseArea{
                    anchors.fill: parent
                    enabled: objColumn.children.length > 2
                    onClicked: {
                        //子节点收起与展开
                        for(var i =1;i<objColumn.children.length-1;i++){
                            objColumn.children[i].visible = !objColumn.children[i].visible
                        }

                        //指示图标旋转
                        parentitem.isExpand = !parentitem.isExpand
                        if(parentitem.isExpand){
                            expandAni.start()
                        }
                        else{
                            collapseAni.start()
                        }
                    }
                }
                Text {
                    id: parentName
                    text: paretObjName
                    anchors.left: parent.left
                    anchors.leftMargin: 30
                    anchors.verticalCenter: parent.verticalCenter
                    width: contentWidth
                    height: contentHeight
                    font.pixelSize: 14
                    font.family: EFont.textHanSansRegular
                    color: parentitem.isExpand?"white" : EColor.textColor(EColor.Text_Placeholder)
                }
                Text{//指示图标
                    id:parentIndicator
                    anchors.right: parent.right
                    anchors.rightMargin: 30
                    anchors.verticalCenter: parent.verticalCenter
                    color: "white"
                    font.family: EFont.iconRegular
                    font.pixelSize: 14
                    width: contentWidth
                    height: contentHeight
                    text: "\uf105"
                    RotationAnimation{
                        id:expandAni
                        target: parentIndicator
                        to:90
                        duration: 100
                    }
                    RotationAnimation{
                        id:collapseAni
                        target: parentIndicator
                        to:0
                        duration: 100
                    }
                }
            }
            Repeater{//子节点
                id:childNode
                model: childenList

                delegate:Rectangle{
                    id:childroot
                    width: expandableListView.width
                    height: 50
                    color: "#222d3c"
                    Text {
                        id: childName
                        text: childObjName
                        anchors.left: parent.left
                        anchors.leftMargin: 30
                        anchors.verticalCenter: parent.verticalCenter
                        width: contentWidth
                        height: contentHeight
                        font.pixelSize: 14
                        font.family: EFont.textHanSansNormal
                        color: currChildIndex === index && expandableListView.currentIndex === parentIndex?
                                   EColor.mainColor(EColor.MColor_0) :
                                   mouseArea.hovered ? EColor.mainColor(EColor.MColor_0):EColor.textColor(EColor.Text_Placeholder)
                    }
                    MouseArea{
                        id:mouseArea
                        anchors.fill: parent
                        property bool hovered: false
                        onClicked: {
                            expandableListView.currentIndex = parentIndex
                            currChildIndex = index
                        }
                        hoverEnabled: true
                        onEntered: {
                            hovered = true
                        }
                        onExited: {
                            hovered = false
                        }
                    }
                }//end Repeater delegate
            }//end Repeater
        }//end objColumn
    }//end detailExpandableListDelegate

}
