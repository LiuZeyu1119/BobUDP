#ifndef ECLIPBOARD_H
#define ECLIPBOARD_H

#include <QObject>
#include <QClipboard>
#include <QColor>

class EClipBoard : public QObject
{
    Q_OBJECT
public:
    explicit EClipBoard(QObject *parent = nullptr);
    Q_INVOKABLE void copyText(QString text);
    Q_INVOKABLE void copyColor(QColor color);
signals:
    void sigCopySuccess(QString message);
private:
    QClipboard *clipboard;
};

#endif // ECLIPBOARD_H
