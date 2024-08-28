#include "MyColor.h"

#include <QQmlEngine>
#include <QDebug>

MyColor &MyColor::getInstance()
{
    static MyColor getInstance;
    return getInstance;
}

QObject *MyColor::Provider(QQmlEngine *, QJSEngine *)
{

    Q_ASSERT(&getInstance);
    QQmlEngine::setObjectOwnership(&getInstance(),QQmlEngine::CppOwnership);
    return &getInstance();

}

MyColor::MyColor(QObject *parent)
    :QObject(parent)
{
    qmlRegisterSingletonType<MyColor>("EUIpackage",1,0,"EColor",MyColor::Provider);
}

MyColor::~MyColor()
{
    qDebug()<<__FUNCTION__;
}


QColor MyColor::mainColor(MyColor::MAINCOLOR type)
{
    switch (type)
    {
    case MColor_0: return QColor("#3a8ee6");
    case MColor_1: return QColor("#409eff");
    case MColor_2: return QColor("#53a8ff");
    case MColor_3: return QColor("#66b1ff");
    case MColor_4: return QColor("#79bbff");
    case MColor_5: return QColor("#8cc5ff");
    case MColor_6: return QColor("#a0cfff");
    case MColor_7: return QColor("#b3d8ff");
    case MColor_8: return QColor("#c6e2ff");
    case MColor_9: return QColor("#d9ecff");
    case MColor_10: return QColor("#ecf5ff");
    }
    return QColor();
}

QColor MyColor::stateColor(MyColor::STATECOLOR type)
{
    switch (type)
    {
    case Success_0: return QColor("#67c23a");
    case Success_1: return QColor("#85ce61");
    case Success_2: return QColor("#e1f3d8");
    case Success_3: return QColor("#f0f9eb");

    case Warning_0: return QColor("#e6a23c");
    case Warning_1: return QColor("#ebb563");
    case Warning_2: return QColor("#faecd8");
    case Warning_3: return QColor("#fdf6ec");

    case Danger_0: return QColor("#f56c6c");
    case Danger_1: return QColor("#f78989");
    case Danger_2: return QColor("#fde2e2");
    case Danger_3: return QColor("#fef0f0");

    case Info_0: return QColor("#909399");
    case Info_1: return QColor("#a6a9ad");
    case Info_2: return QColor("#e9e9eb");
    case Info_3: return QColor("#f4f4f5");
    }
    return QColor();
}

QColor MyColor::textColor(MyColor::TEXTCOLOR type)
{
    switch (type)
    {
    case Text_Main: return QColor("#303133");
    case Text_Routine: return QColor("#606266");
    case Text_Secondary: return QColor("#909399");
    case Text_Placeholder: return QColor("#C0C4CC");
    }
    return QColor();
}

QColor MyColor::borderColor(MyColor::BORDERCOLOR type)
{
    switch (type)
    {
    case Border_1: return QColor("#DCDFE6");
    case Border_2: return QColor("#E4E7ED");
    case Border_3: return QColor("#EBEEF5");
    case Border_4: return QColor("#F2F6FC");
    }
    return QColor();
}

QColor MyColor::bgColor(MyColor::BGCOLOR type)
{
    switch (type)
    {
    case BGColor_1: return QColor("#F0F2F5");
    case BGColor_2: return QColor("#F5F7Fa");
    }
    return QColor();
}






