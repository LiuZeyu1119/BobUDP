import QtQuick 2.12
import QtQuick.Window 2.12
//import Qt5Compat.QtGraphicalEffects 1.13
import Qt5Compat.GraphicalEffects
import QtQuick.Controls 2.5
import QtQuick.Controls.Basic 2.5
import QtMultimedia
import QtQuick.Dialogs
import EUIpackage 1.0
import EControl 1.0
import "./showpage"



Window {
    id: root
    visible: true
    width: 1024
    height: 768
    maximumWidth: 1024
    maximumHeight: 768
    minimumWidth: 1024
    minimumHeight: 768
    flags: Qt.FramelessWindowHint
    modality:Qt.ApplicationModal
    //color: "blue"
    color: "#00000000"
    //  拖动窗口
    property var dragPosition: Qt.point(0, 0)
    property int dragX: 0
    property int dragY: 0
    property bool dragging: false

    property int clickCount : 0

    function getTime()
    {
        return Qt.formatDateTime(new Date(), "yyyy-MM-dd hh:mm:ss.zzz : ");
    }

    function stopSend()
    {
        maincontrol.stopSending();
        startBTN.enabled=true;
        exitBTN.enabled=false;
        editBTN.enabled=true;
        outPutConsole.append(getTime() + "停止发送")
        freqSlider.enabled = true
        numSlider.enabled = true
        threadSlider.enabled = true
    }
    Connections{
        target: maincontrol
        onSendingStopped: {
            mytoast.showToast("已发送全部数据包，等待发送任务完成",EToast.SUCCESS.INFO,3000)
            stopSend()
        }

    }

    //  确保窗口可以拖动
    Rectangle{
        width: 900
        height: 50
        z:2
        color: "#00000000"
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            z:0
            onPressed: function(mouse){
                // 记录拖动时的初始位置
                root.dragX = mouseX
                root.dragY = mouseY
                dragging = true
            }
            onReleased:function(mouse){ dragging = false}
            onPositionChanged:function(mouse)
            {
                if(dragging)
                {
                    root.x += mouse.x - root.dragX
                    root.y += mouse.y - root.dragY
                }
            }
        }
    }

    Rectangle{//主界面
            id:inrec
            anchors.fill:parent
            radius:15
            opacity:0.97
            //color: "blue"

            Image {
                    id: bg
                    source: "qrc:/image/background.jpg"
                    sourceSize: Qt.size(parent.width, parent.height)
                    smooth: true
                    visible: false
            }

            GaussianBlur {
                anchors.fill: bg
                source: bg
                radius: 255
                samples: 255
            }


            layer.enabled: true
            layer.effect: OpacityMask {

                maskSource: Rectangle {
                    width: inrec.width
                    height: inrec.height
                    radius: inrec.radius


                }

            }

            // EPagination{
            //     x:850
            //     y:720
            //     z:10
            //     id:pagination
            //     //anchors.centerIn: parent.Center
            //     //anchors.left: parent.left
            //     //anchors.bottom: parent.bottom
            //     anchors.margins: 3
            //     cusCount:2
            //     //cusCurrentPage : mainView.currentIndex + 1
            //     onCusCurrentPageChanged:{
            //         //console.log("epagination1>>"+cusCurrentPage)
            //         mainView.currentIndex = cusCurrentPage - 1
            //     }
            // }
            //  关闭按钮
            Row {
                id: closeRow
                x: 970
                y: 22
                z: 1
                width: 102
                height: 56
                spacing: 8
                // EIconInfoBtn{
                //     width: 15
                //     height: 15
                //     id : frontBTN
                //     cusIcon: "\u0020"
                // }
                // EIconWarningBtn{
                //     width: 15
                //     height: 15
                //     id : hideBTN
                //     cusIcon: "\u0020"


                // }
                EIconDangerBtn{
                    width: 15
                    height: 15
                    id : closeBTN
                    cusIcon: "\u0020"
                    onClicked:{
                        root.close()
                    }
                }
            }


            SwipeView {
                id: mainView
                currentIndex: 0
                anchors.fill: parent

                Rectangle{
                   id:page1
                   //anchors.centerIn: parent
                   color: "#DFFFFFFF"
                   //ColorAnimation on color { to: "#DFFFFFFF"; duration: 1000 }
                   //opacity:0.5
                   EToast{
                       id:mytoast
                       z:100
                       anchors.horizontalCenter: parent.horizontalCenter
                       anchors.top: parent.top
                   }

                   //  标题
                   Row {
                       x: 440
                       y: 100
                       z: 2
                       width: 100
                       height:100

                       Button{
                            text: qsTr("Bob UDP")
                            font.capitalization: Font.MixedCase
                            flat: true
                            font.pixelSize: 40
                            font.bold: true
                            palette.buttonText: "black"
                           //彩蛋
                            onClicked: {
                                //this.text = "i"
                                clickCount ++
                                console.log(clickCount)
                                if(clickCount == 1) mytoast.showToast("不要点我，这里什么也没有！",EToast.StyleEnum.INFO,1000)
                                if(clickCount == 3) mytoast.showToast("不要再点了，这里真的什么也没有！",EToast.StyleEnum.WARNING,1000)
                                if(clickCount == 5) mytoast.showToast("再点我生气了！",EToast.StyleEnum.WARNING,1000)
                                if(clickCount == 7) mytoast.showToast("真的生气了！",EToast.StyleEnum.ERROR,1000)
                                if(clickCount == 9) mytoast.showToast("...",EToast.StyleEnum.WARNING,1000)
                                if(clickCount == 11) mytoast.showToast("我真的生气了！",EToast.StyleEnum.ERROR,1000)
                                if(clickCount == 13) mytoast.showToast("...",EToast.StyleEnum.WARNING,1000)
                                if(clickCount == 15) mytoast.showToast("不骗你，我生气了！！！",EToast.StyleEnum.ERROR,1000)
                                if(clickCount == 17) mytoast.showToast("我会把这个软件毁掉，让你再也不能运行！",EToast.StyleEnum.WARNING,1000)
                                if(clickCount == 19) {
                                    mytoast.showToast("你看！这都是你自讨苦吃",EToast.StyleEnum.ERROR,1000)
                                    closeRow.visible = false
                                    ctrlRow.visible = false
                                    ipPortRow.visible = false
                                    textedit_row.visible = false
                                }
                                if(clickCount == 20) {
                                    mytoast.showToast("???",EToast.StyleEnum.ERROR,1000)
                                }
                                if(clickCount == 21) {
                                    mytoast.showToast("????????",EToast.StyleEnum.ERROR,1000)
                                }
                                if(clickCount == 22) {
                                    mytoast.showToast("??????????????????????????",EToast.StyleEnum.ERROR,1000)
                                }
                                if(clickCount == 23) {
                                    mytoast.showToast("好吧,既然你这么执着...",EToast.StyleEnum.ERROR,1000)
                                    closeRow.visible = true
                                    ctrlRow.visible = true
                                    ipPortRow.visible = true
                                    textedit_row.visible = true
                                }
                                if(clickCount >= 24) {
                                    mytoast.showToast("好吧,既然你这么执着...",EToast.StyleEnum.ERROR,1000)
                                    aboutWindow.visible = true

                                }
                           }
                       }

                   }
                   AboutWindow {
                       id:aboutWindow
                       visible: false
                   }


                   Row {
                       id: ipPortRow
                       x: 135
                       y: 200
                       width: 837
                       height: 110
                       anchors.margins: 8
                       layer.smooth: false
                       spacing: 8
                       EIconBaseBtn{
                           id : getIpPortBTN
                           cusIcon: "\uf044"
                           onClicked: {
                                sourceIPEDIT.text = maincontrol.getMyIP()
                            }
                       }
                       EBaseInput{
                           width : 200
                           id : sourceIPEDIT
                           placeholderText: "Source IP"
                           enabled: false
                       }
                       EBaseInput{
                           width : 100
                           id : sourcePortEDIT
                           placeholderText: "Source Port"
                           //enabled: false
                       }
                       AnimatedImage {
                            height:40
                            width:40
                            id: animated
                            rotation: 180
                            source: "qrc:/image/transing.gif"

                        }
                       EBaseInput{
                           width : 200
                           id : targetIPEDIT
                           placeholderText: "Target IP"
                           //enabled: false
                       }
                       EBaseInput{
                           width : 100
                           id : targetPortEDIT
                           placeholderText: "Target Port"
                           //enabled: false
                       }
                       FileDialog {
                              id: fileDialog
                              title: "打开xml文件"
                              nameFilters: ["XML files (*.xml)"]
                              acceptLabel: "确定"
                              rejectLabel: "取消"
                              fileMode: FileDialog.OpenFile
                              onAccepted: {
                                //mytoast.setCusColor(EColor.stateColor(EColor.BGColor_2),EColor.stateColor(EColor.Danger_2),"\uf4c7")
                                //mytoast.showToast("这是一段信息，toast样式自定义",EToast.StyleEnum.CUSTOMSTYLE,3000)
                                if(maincontrol.selectXMLFile(currentFile)){
                                    mytoast.showToast("导入文件成功啦！",EToast.SUCCESS.INFO,3000)
                                    outPutConsole.append (getTime() + "导入成功\n"+ maincontrol.getProtocolConfigAsString())
                                    sourceIPEDIT.text = maincontrol.getSourceIP();
                                    sourcePortEDIT.text = maincontrol.getSourcePort();
                                    targetIPEDIT.text = maincontrol.getDestinationIP()
                                    targetPortEDIT.text = maincontrol.getDestinationPort();
                                    outPutConsole.append(getTime() + "准备就绪")
                                }else{
                                    mytoast.showToast("导入文件失败了！",EToast.StyleEnum.ERROR,3000)
                                }

                              }
                          }
                       EIconBaseBtn{
                           id : fileInputBTN
                           cusIcon: "\uf002"
                           onClicked: {
                                fileDialog.open()
                            }
                       }


                   }
                   //控制按钮
                   Row {
                       id: ctrlRow
                       x: 230
                       y: 305
                       width: 345
                       height: 101
                       layer.smooth: true
                       spacing: 100
                       ESuccessBtn{
                           id : startBTN
                           cusText: "发送"
                           cusStyle: EDangerBtn.BtnStyle.Simple
                           //enabled: false
                           onClicked:{
                               if(targetIPEDIT.text.trim() === ""||
                                    targetPortEDIT.text.trim() === ""){
                                    mytoast.showToast("请输入完整的信息再发送",EToast.StyleEnum.ERROR,3000)
                               }else{
                                    maincontrol.setDestinationIP(targetIPEDIT.text)
                                    maincontrol.setDestinationPort(targetPortEDIT.text)
                                    console.log("开始发送")
                                    // maincontrol.initializeServer(freqSlider.value,numSlider.value)
                                    maincontrol.startSending();
                                    exitBTN.enabled=true;
                                    startBTN.enabled=false;
                                    editBTN.enabled=false;

                                    freqSlider.enabled = false
                                    numSlider.enabled = false
                                    threadSlider.enabled = false
                                    outPutConsole.append(getTime() + "开始发送")
                               }
                           }

                       }

                       EDangerBtn{
                           id : exitBTN
                           cusText: "停止"
                           cusStyle: EDangerBtn.BtnStyle.Simple
                           enabled: false
                           onClicked:{
                                stopSend()
                           }
                       }
                       EMainBtn{
                           id : editBTN
                           cusText: "修改"
                           cusStyle: EInfoBtn.BtnStyle.Simple
                           //enabled: false
                           onClicked:{
                                if (targetIPEDIT.text.trim() === ""||
                                    targetPortEDIT.text.trim() === "")
                                {
                                    mytoast.showToast("请输入完整的信息再修改",EToast.StyleEnum.ERROR,3000)
                                }
                               else {
                                    if(maincontrol.checkIPString(targetIPEDIT.text)){
                                        maincontrol.setDestinationIP(targetIPEDIT.text)
                                        outPutConsole.append(getTime() + "当前IP地址为："+targetIPEDIT.text )
                                    }else{
                                        mytoast.showToast("输入的IP地址不正确",EToast.StyleEnum.ERROR,3000)
                                    }
                                    if(maincontrol.checkPortString(targetPortEDIT.text)){
                                        maincontrol.setDestinationPort(targetPortEDIT.text)
                                        outPutConsole.append(getTime() + "当前端口为："+targetPortEDIT.text )

                                    }else{
                                        mytoast.showToast("输入端口号不正确",EToast.StyleEnum.ERROR,3000)
                                    }


                                }
                           }
                       }

                   }

                    Row{
                        id: textedit_row
                        spacing: 10
                        x:70
                        y:450
                        width: 900
                        height: 280
                        ScrollView {
                            id: textedit_1_view
                            width: parent.width
                            height: parent.height
                            background: Rectangle{
                                //border.color: "#F0FFF0"
                                //border.width: 1
                                //border.color: textedit_1.activeFocus? "#7FFFAA": "#7FFFAA"
                                //border.width: textedit_1.activeFocus? 2: 1
                                radius: 15
                                color:"WhiteSmoke"
                            }
                            clip: true
                            ScrollBar.horizontal: ScrollBar{ visible: false }

                            TextEdit{
                                id: outPutConsole
                                width: textedit_1_view.width
                                padding: 20
                                color: "#8FBC8F"
                                text: getTime() + "等待指令"
                                //支持富文本
                                //textFormat: TextEdit.RichText
                                //光标样式是可以自定义的
                                //cursorVisible: focus
                                //鼠标选取文本默认为false
                                selectByMouse: true
                                //键盘选取文本默认为true
                                selectByKeyboard: true
                                //选中文本的颜色
                                selectedTextColor: "#8FBC8F"
                                //选中文本背景色
                                selectionColor: "#90EE90"
                                //超出宽度时开启允许滚动，默认为true
                                //字体的属性也比较多，可以自行看文档
                                font{
                                    family: "SimSun"
                                    pixelSize: 16
                                }
                                renderType: Text.NativeRendering
                                wrapMode: TextEdit.Wrap
                            }
                        }
                    }


               }
                Rectangle{
                    id:page2
                    color: "#DFFFFFFF"
                    Button{
                        id:settingBTN
                        x:80
                        y:90

                        text: qsTr("设置")
                        // font.capitalization: Font.MixedCase
                        flat: true
                        font.pixelSize: 45
                        font.bold: true
                        palette.buttonText: "black"
                        onClicked:{
                            mainView.currentIndex=0
                        }
                    }
                    Rectangle{
                        id:setting_outoutside
                        x:75
                        y:175
                        z:1
                        width:880
                        height: 550
                        color:"#00FFFFFF"
                    }

                    Rectangle{
                        id:setting_outside
                        x:100
                        y:200
                        z:2
                        width:830
                        height: 500
                        color:"#5FFFFFFF"
                        radius: 15
                        smooth: true

                        Rectangle{
                            id:setting_inside
                            x:50
                            y:50
                            z:3
                            width:730
                            height: 400
                            color:"#00FFFFFF"
                            Column{
                                spacing: 20
                                // Row{
                                //     ECheckbox{
                                //         text: "加密"
                                //     }
                                // }
                                Column{
                                    padding: 20
                                    spacing: 20
                                    Text{
                                        text:"发送频率"
                                        styleColor: "#4d4b4b"
                                        font.pixelSize:20
                                        color:"grey"
                                    }
                                    Row{
                                        spacing: 20
                                        ESlider{
                                            id: freqSlider
                                            width: 600
                                            from: 1
                                            to: 10000
                                            stepSize: 1
                                            Timer {
                                                id: releaseTimer
                                                interval: 100 // 调整时间间隔以满足需求
                                                repeat: false
                                                onTriggered: {
                                                    maincontrol.setFrequence(freqSlider.value)
                                                    outPutConsole.append(getTime() + "频率设置为：" + freqSlider.value)
                                                }
                                            }

                                            onValueChanged: {
                                                releaseTimer.stop() // 每次值改变时重置Timer
                                                releaseTimer.start()
                                            }
                                        }
                                        Text {
                                            text: freqSlider.value.toString() + "次/秒"
                                            width: contentWidth
                                            height: contentHeight
                                            font.pixelSize: 16
                                            color: EColor.mainColor(EColor.MColor_2)
                                            font.family: EFont.textHanSansNormal
                                        }
                                    }
                                }
                                Column{
                                    padding: 20
                                    spacing: 20
                                    Text{
                                        text:"发送数量"
                                        styleColor: "#4d4b4b"
                                        font.pixelSize:20
                                        color:"grey"
                                    }
                                    Row{
                                        spacing: 20
                                        ESlider{
                                            id:numSlider
                                            width:600
                                            from:1
                                            to:100000
                                            stepSize:1
                                            Timer {
                                                id: releaseTimer1
                                                interval: 100 // 调整时间间隔以满足需求
                                                repeat: false
                                                onTriggered: {
                                                    maincontrol.setNumber(numSlider.value)
                                                    outPutConsole.append(getTime() + "数量设置为：" + numSlider.value)
                                                }
                                            }

                                            onValueChanged: {
                                                releaseTimer1.stop() // 每次值改变时重置Timer
                                                releaseTimer1.start()
                                            }
                                        }
                                        Text {
                                            text: numSlider.value.toString() + "个"
                                            width: contentWidth
                                            height: contentHeight
                                            font.pixelSize: 16
                                            color: EColor.mainColor(EColor.MColor_2)
                                            font.family: EFont.textHanSansNormal
                                        }
                                    }
                                }
                                Column{
                                    padding: 20
                                    spacing: 20
                                    Text{
                                        text:"线程数量"
                                        styleColor: "#4d4b4b"
                                        font.pixelSize:20
                                        color:"grey"
                                    }

                                    Row{
                                        spacing: 20
                                        ESlider{
                                            id:threadSlider
                                            width:600
                                            from:1
                                            to:25
                                            stepSize:1
                                            Timer {
                                                id: releaseTimer2
                                                interval: 100 // 调整时间间隔以满足需求
                                                repeat: false
                                                onTriggered: {
                                                     maincontrol.setThreadNum(threadSlider.value)
                                                    outPutConsole.append(getTime() + "线程数设置为：" + threadSlider.value)
                                                }
                                            }

                                            onValueChanged: {
                                                releaseTimer2.stop() // 每次值改变时重置Timer
                                                releaseTimer2.start()
                                            }
                                        }
                                        Text {
                                            text: threadSlider.value.toString() + "个"
                                            width: contentWidth
                                            height: contentHeight
                                            font.pixelSize: 16
                                            color: EColor.mainColor(EColor.MColor_2)
                                            font.family: EFont.textHanSansNormal
                                        }
                                    }
                                }

                            }


                        }
                    }
                    FastBlur {
                        z:0
                        anchors.fill: setting_outoutside
                        source: setting_outside
                        radius: 128
                        transparentBorder: true

                    }

                }
                Rectangle{
                    id: page3
                    color: "#DFFFFFFF"
                    Button{
                        id:serachBTNTAG
                        x:80
                        y:90

                        text: qsTr("搜索")
                        // font.capitalization: Font.MixedCase
                        flat: true
                        font.pixelSize: 45
                        font.bold: true
                        palette.buttonText: "black"
                        onClicked:{
                            mainView.currentIndex=0
                        }
                    }
                    Column{
                        x: 135
                        y: 200
                        width: 837
                        height: 110
                        anchors.margins: 8
                        spacing: 32
                        layer.smooth: false
                        Row {
                            id: sqlSearch
                            spacing: 15
                            EBaseInput{
                                width : 750
                                id : sqlSendSearchInput
                                placeholderText: "查发送"
                            }
                            EIconBaseBtn{
                                id : sqlSendSearchBtn
                                cusIcon: "\uf002"
                                onClicked: {
                                    var results = maincontrol.searchInSendDb(sqlSendSearchInput.text);
                                    console.log(results)
                                    sendTableModel.clearData();
                                    for (var i = 0; i < results.length; i++) {
                                        sendTableModel.addData(results[i]);
                                    }


                                }
                            }
                        }
                        Row{
                            id: sqlSearch2
                            spacing: 15
                            EBaseInput{
                                width : 750
                                id : sqlRecSearchInput
                                placeholderText: "查接收"
                            }
                            EIconBaseBtn{
                                id : sqlRecSearchBtn
                                cusIcon: "\uf002"
                                onClicked: {
                                    var results = maincontrol.searchInRecDb(sqlRecSearchInput.text);
                                    console.log(results)
                                    sendTableModel.clearData();
                                    for (var i = 0; i < results.length; i++) {
                                        sendTableModel.addData(results[i]);
                                    }
                                }
                            }

                        }
                        Row {
                            x:30
                            spacing: 80
                            Text { text: "ID"; font.bold: true }
                            Text { text: "           时间戳"; font.bold: true ;color:"#2F4F4F"}
                            Text { text: "                         IP"; font.bold: true ;color:"#2F4F4F"}
                            Text { text: "        端口"; font.bold: true ;color:"#2F4F4F"}
                            Text { text: "  数据"; font.bold: true ;color:"#2F4F4F"}
                        }
                        Rectangle{
                            x:30
                            id:searchResult
                            z:2
                            width:730
                            height: 300
                            color:"#00FFFFFF"

                            smooth: true
                            Column {
                                anchors.fill: parent
                                // 数据表
                                TableView {
                                    id: sendTableView
                                    model: sendTableModel
                                    anchors.fill: parent
                                    anchors.top: parent.top
                                    columnSpacing: 8
                                    rowSpacing: 8
                                    clip: true
                                    // 分割线

                                    delegate: Item {
                                        implicitWidth: 100
                                        implicitHeight: 50
                                        Row {
                                            spacing: 80
                                            Text { text: model.id ;color:"#2F4F4F"}
                                            Text { text: model.timestamp ;color:"#2F4F4F"}
                                            Text { text: model.sender_ip ;color:"#2F4F4F"}
                                            Text { text: model.sender_port ;color:"#2F4F4F"}
                                            Text { text: model.data ;color:"#2F4F4F"}
                                        }
                                    }
                                }
                            }

                        }


                    }

                }

            }

    }


}
