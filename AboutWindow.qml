import QtQuick 2.15
import QtQuick.Controls 2.15

Window {
    visible: true
    width: 800
    height: 600
    title: "Inspirational Text"
    flags: Qt.WindowStaysOnTopHint
    // 样式
    Rectangle {
        width: parent.width
        height: parent.height
        color: "#f5f5f5"  // 背景色

        // 长文本显示区域
        TextEdit {
            id: textEdit
            width: parent.width - 40
            height: parent.height - 40
            text: "Here's to the crazy ones.\n" +
                  "The misfits.\n" +
                  "The rebels.\n" +
                  "The troublemakers.\n" +
                  "The round pegs in the square holes.\n" +
                  "The ones who see things differently.\n" +
                  "They're not fond of rules\n" +
                  "And they have no respect for the status quo.\n" +
                  "You can praise them, quote them, disagree with them\n" +
                  "disbelieve them, glorify or vilify them.\n" +
                  "About the only thing that you can't do is ignore them.\n" +
                  "Because they change things.\n" +
                  "They invent. They imagine. They heal.\n" +
                  "They explore. They create. They inspire.\n" +
                  "They push the human race forward.\n" +
                  "Maybe they have to be crazy.\n" +
                  "How else can you stare at an empty canvas and see a work of art?\n" +
                  "Or sit in silence and hear a song that's never been written?\n" +
                  "Or gaze at a red planet and see a laboratory on wheels?\n" +
                  "We make tools for these kinds of people.\n" +
                  "While some may see them as the crazy ones, we see genius.\n" +
                  "Because the people who are crazy enough to think that they can\n" +
                  "change the world, are the ones who do."
            wrapMode: TextEdit.Wrap  // 自动换行
            font {
                family: "Arial"
                pixelSize: 18
            }
        }
    }
}
