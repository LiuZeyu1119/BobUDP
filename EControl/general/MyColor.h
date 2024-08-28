#ifndef MYCOLOR_H
#define MYCOLOR_H
#include <QObject>
#include <QColor>
#include <iostream>

class QJSEngine;

class MyColor : public QObject
{
    Q_OBJECT

public:
    static MyColor& getInstance();

    Q_ENUMS(MAINCOLOR)
    Q_ENUMS(STATECOLOR)
    Q_ENUMS(TEXTCOLOR)
    Q_ENUMS(BORDERCOLOR)
    Q_ENUMS(BGCOLOR)

    enum MAINCOLOR
    {
        MColor_0,
        MColor_1,
        MColor_2,
        MColor_3,
        MColor_4,
        MColor_5,
        MColor_6,
        MColor_7,
        MColor_8,
        MColor_9,
        MColor_10
    };

    enum STATECOLOR
    {
        Success_0,
        Success_1,
        Success_2,
        Success_3,
        Warning_0,
        Warning_1,
        Warning_2,
        Warning_3,
        Danger_0,
        Danger_1,
        Danger_2,
        Danger_3,
        Info_0,
        Info_1,
        Info_2,
        Info_3,
    };

    enum TEXTCOLOR
    {
        Text_Main,
        Text_Routine,
        Text_Secondary,
        Text_Placeholder,
    };

    enum BORDERCOLOR
    {
        Border_1,
        Border_2,
        Border_3,
        Border_4,
    };

    enum BGCOLOR
    {
        BGColor_1,
        BGColor_2,
    };

    //qml获取设定颜色
    Q_INVOKABLE QColor mainColor(MAINCOLOR);
    Q_INVOKABLE QColor stateColor(STATECOLOR);
    Q_INVOKABLE QColor textColor(TEXTCOLOR);
    Q_INVOKABLE QColor borderColor(BORDERCOLOR);
    Q_INVOKABLE QColor bgColor(BGCOLOR);
signals:

private:
    static QObject* Provider(class QQmlEngine*,class QJSEngine*);

    MyColor(QObject* parent= nullptr);
    ~MyColor();
};
#endif // MYCOLOR_H
