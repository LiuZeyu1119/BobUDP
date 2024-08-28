#ifndef MYFONT_H
#define MYFONT_H

#include <QObject>
#include <iostream>
#include <QFont>

class MyFont : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString iconRegular READ iconRegular  NOTIFY notifyChanged)
    Q_PROPERTY(QString iconSolid READ iconSolid  NOTIFY notifyChanged)

    //字体
    //思源黑体
    Q_PROPERTY(QString textHanSansRegular READ textHanSansRegular  NOTIFY notifyChanged)
    Q_PROPERTY(QString textHanSansMedium READ textHanSansMedium  NOTIFY notifyChanged)
    Q_PROPERTY(QString textHanSansNormal READ textHanSansNormal  NOTIFY notifyChanged)

public:
    static MyFont & getInstance();

    QString iconRegular();
    QString iconSolid();
    QString textHanSansRegular();
    QString textHanSansMedium();
    QString textHanSansNormal();

    QString getFontByPath(const QString);
signals:
    void notifyChanged();
public slots:

private:
    static QObject* provider(class QQmlEngine *,class QJSEngine *);
    explicit MyFont(QObject *parent = nullptr);
    ~MyFont();
};

#endif // MYFONT_H
