#include "EClipBoard.h"

#include <QGuiApplication>

EClipBoard::EClipBoard(QObject *parent) : QObject(parent)
{
    clipboard = QGuiApplication::clipboard();
}

void EClipBoard::copyText(QString text)
{
    clipboard->setText(text);
}

void EClipBoard::copyColor(QColor color)
{
    clipboard->setText(color.name());
    emit sigCopySuccess(color.name());
}
