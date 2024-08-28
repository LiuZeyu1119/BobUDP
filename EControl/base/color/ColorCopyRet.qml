import QtQuick 2.0
import EUIpackage 1.0

Rectangle{
    signal sigCopyColorSuccess(var colorName)
    MouseArea{
        anchors.fill: parent
        onDoubleClicked: {
            eClipboard.copyColor(parent.color)
        }
    }
    EClipboard{
        id:eClipboard
    }
    Connections{
        target: eClipboard
        //Qt 5.15之前写法
        /*
        onSigCopySuccess:{
            sigCopyColorSuccess(message)
        }
        */

        function onSigCopySuccess(message){
            sigCopyColorSuccess(message)
        }
    }
}
