import QtQuick 2.12
import QtQuick.Controls 2.12

import EUIpackage 1.0

Item {
    id:root
    width: 800
    height: 500

    property int toastNum: 1

    enum StyleEnum{
        SUCCESS,
        WARNING,
        INFO,
        ERROR,
        CUSTOMSTYLE
    }

    // 定义model
    ListModel {
        id: mymodel
        ListElement{
            Massage:""
            Style:0
            EndTime:0
            TimerRunning:false
            Wid:75
        }
    }

    // 定义delegate toast样式
    Component {
        id: toastDelegate
        Item {
            id: wrapper

            width: root.width
            height: index ===0? 20 : 55   //第一个参数指定透明Item的高度，第一个toast的初始位置为 first Item.height+spacing
            property var currIndex:index
            onCurrIndexChanged: {
                if(index===0)
                    toastBg.color = "transparent"
                else if(index >0)
                    toastBg.color = wrapper.getBgColor()
            }

            Rectangle {
                id: toastBg
                anchors.centerIn: parent
                color: "transparent"
                width: info.contentWidth >415 ? 500 : info.contentWidth+85
                height: index ===0? 20 : 55
                radius: 4

                Text{
                    id:icon
                    width: contentWidth
                    height: contentHeight
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 18
                    text:wrapper.getIcon()
                    font.pixelSize:22
                    font.family:EFont.iconSolid
                    color: wrapper.getTextColor()
                    visible: index !== 0
                }

                Text {
                    id: info
                    width: contentWidth >415? 415 :contentWidth
                    height: parent.height
                    verticalAlignment: Text.AlignVCenter
                    anchors.left: parent.left
                    anchors.leftMargin:52
                    color: wrapper.getTextColor()
                    text: qsTr(Massage)
                    font.pixelSize:16
                    wrapMode: Text.Wrap
                }
                Text {
                    id: close
                    width: contentWidth
                    height: contentHeight
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: info.right
                    anchors.leftMargin:8
                    color: wrapper.getTextColor()
                    text: "\uf00d"
                    font.pixelSize:22
                    font.family:EFont.iconSolid
                    visible:index !== 0 && (TimerRunning==null? false : !TimerRunning)
                }
                MouseArea{
                    width: 24
                    height: 24
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin:16
                    visible: index !== 0 && (TimerRunning==null? false : !TimerRunning)
                    onClicked: {
                        if(!TimerRunning){
                            //console.log("clicked")
                            listView.delOne(index)
                        }
                    }
                }
            }

            Timer{
                id:toastNumTimer
                interval: EndTime          //默认4秒关闭Toast
                running: index ===0? false : (TimerRunning==null? false :TimerRunning)
                repeat: false
                triggeredOnStart:false
                onTriggered: {
                    //console.log("1toastNum:"+(toastNum))
                    listView.delOne(index)
                }
            }
            function getBgColor(){
                switch (Style){
                case EToast.StyleEnum.WARNING:
                    return  EColor.stateColor(EColor.Warning_2)
                case EToast.StyleEnum.SUCCESS:
                    return  EColor.stateColor(EColor.Success_2)
                case EToast.StyleEnum.ERROR:
                    return EColor.stateColor(EColor.Danger_2)
                case EToast.StyleEnum.CUSTOMSTYLE:
                    return  listView.bgColor
                default:
                    return  EColor.stateColor(EColor.Info_2)
                }
            }

            function getTextColor(){
                switch (Style){
                case EToast.StyleEnum.WARNING:
                    return EColor.stateColor(EColor.Warning_0)
                case EToast.StyleEnum.SUCCESS:
                    return EColor.stateColor(EColor.Success_0)
                case EToast.StyleEnum.ERROR:
                    return EColor.stateColor(EColor.Danger_0)
                case EToast.StyleEnum.CUSTOMSTYLE:
                    return  listView.textColor
                default:
                    return EColor.stateColor(EColor.Info_0)
                }
            }

            function getIcon(){
                switch (Style){
                case EToast.StyleEnum.WARNING:
                    return "\uf06a"
                case EToast.StyleEnum.SUCCESS:
                    return "\uf058"
                case EToast.StyleEnum.ERROR:
                    return "\uf06a"
                case EToast.StyleEnum.CUSTOMSTYLE:
                    return  listView.iconStyle
                default:
                    return "\uf05a"
                }
            }
        }

    }

    // 定义ListView
    ListView {
        id: listView
        width: parent.width
        height: parent.height
        orientation:Qt.Vertical //垂直布局
        spacing: 8             //间隔
        interactive: false      //不可交互
        delegate: toastDelegate //加载delegate
        model: mymodel
        focus: false

        property color bgColor: EColor.mainColor(EColor.MColor_8)
        property color textColor: EColor.mainColor(EColor.MColor_0)
        property string iconStyle : "\uf05a"

        //增加Toast时的动画
        add: Transition {
            NumberAnimation {
                properties: "y"
                from: 0
                duration: 500
            }
        }
        // 用于Model变化导致Toast被迫移位时的动画效果
        addDisplaced: Transition {
            NumberAnimation {
                properties: "y"
                duration: 500
            }
        }

        //删除动画
        remove:Transition {
            NumberAnimation{
                properties: toastNum === 1?"y":"opacity"
                to:0
                duration: 500
            }

        }
        //删除函数
        function delOne(index){
            model.remove(index)
            --toastNum
        }
    }

    /** showToast toast显示函数 外部调用
     *info 提示信息
     *style 四种样式 style类型枚举
     *endTime 停留时间默认4000ms
     *autoDisappear 是否自动消失
     */
    function showToast(info,style,endTime=4000,autoDisappear=true)
    {
        if(autoDisappear)
            var wid= 75
        else
            wid=100

        listView.model.insert(1,
                              {
                                  "Massage": info ,
                                  "Style":style,
                                  "EndTime":endTime,
                                  "TimerRunning":autoDisappear,
                                  "Wid":wid,
                              }
                              )
        ++toastNum
    }

    function setCusColor(bgcolor,textColor,iconStyle ="\uf05a"){
        listView.bgColor =bgcolor
        listView.textColor = textColor
        listView.iconStyle = iconStyle
    }
}
