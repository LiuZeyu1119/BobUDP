import QtQuick 2.0
import QtQuick.Controls 2.5

import EUIpackage 1.0

Rectangle {
    id: control
    width: 124
    height: 124
    radius: width < height ? width/2 : height/2
    color: EColor.borderColor(EColor.Border_2)
    property real from: 0 //最小值
    property real to: 100 //最大值
    property real value: 0 //当前值
    property real cusPercent: (value-from)/(to-from) //百分比[0,1]
    property int cusLineWidth: 6
    property color cusColor: EColor.mainColor(EColor.MColor_1)

    Canvas {
        id: canvas
        width: control.width < control.height ? control.width : control.height
        height: width
        property int canvasRadius: width / 2
        property real begingAngle: 3*Math.PI/2
        property real valueAngle: begingAngle + Math.PI*2*control.cusPercent
        onValueAngleChanged: canvas.requestPaint()
        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0,width,width);
            ctx.lineCap = "round";
            drawValue(ctx);
        }

        //context.arc(x,y,r,sAngle,eAngle,counterclockwise);
        //x:圆的中心的x坐标。
        //y:圆的中心的y坐标。
        //r:圆的半径。
        //sAngle:起始角，以弧度计。（弧的圆形的三点钟位置是0度）。
        //eAngle:结束角，以弧度计。
        //counterclockwise:可选参数。False=顺时针，true=逆时针。

        function drawValue(ctx)
        {
            ctx.beginPath();
            ctx.arc(width/2, width/2, canvasRadius-control.cusLineWidth/2, begingAngle, valueAngle, false);
            ctx.lineWidth = control.cusLineWidth;
            ctx.strokeStyle = control.cusColor;
            ctx.stroke();
            //ctx.restore();
        }
        Rectangle{
            anchors.centerIn: parent
            color: "white"
            width: parent.width-control.cusLineWidth*2
            height: parent.height-control.cusLineWidth*2
            radius: width < height ? width/2 : height/2
            Text {
                id: txt
                anchors.centerIn: parent
                font.family: EFont.textHanSansMedium
                font.pixelSize: 16
                font.bold: true
                color: control.cusColor
                text: qsTr("%1 %").arg(control.cusPercent.toFixed(2)*100);
            }
        }

    }
}
