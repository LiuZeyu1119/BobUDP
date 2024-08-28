#include "MyFont.h"
#include <QDebug>
#include <QFontDatabase>
#include <QQmlEngine>

MyFont &MyFont::getInstance()
{
    static MyFont instance;
    return  instance;
}

QString MyFont::iconRegular()
{
    static QString fontName;
    if(fontName.isEmpty()){
        fontName = getFontByPath(":/font/fa-regular-400.ttf");
    }
    return  fontName;
}

QString MyFont::iconSolid()
{
    static QString fontName;
    if(fontName.isEmpty()){
        fontName = getFontByPath(":/font/fa-solid-900.ttf");
    }
    return  fontName;
}

QString MyFont::textHanSansRegular()
{
    static QString fontName;
    if(fontName.isEmpty()){
        fontName = getFontByPath(":/font/SourceHanSans-Regular.ttf");
    }
    return  fontName;
}

QString MyFont::textHanSansMedium()
{
    static QString fontName;
    if(fontName.isEmpty()){
        fontName = getFontByPath(":/font/SourceHanSans-Medium.ttf");
    }
    return  fontName;
}

QString MyFont::textHanSansNormal()
{
    static QString fontName;
    if(fontName.isEmpty()){
        fontName = getFontByPath(":/font/SourceHanSansSC-Normal-2.otf");
    }
    return  fontName;
}


QString MyFont::getFontByPath(const QString path)
{
    int fontId = QFontDatabase::addApplicationFont(path);
    QStringList loadedFontFamilies = QFontDatabase::applicationFontFamilies(fontId);
    QFont font;
    font.setFamily(loadedFontFamilies.at(0));
    return font.family();
}

QObject *MyFont::provider(QQmlEngine *, QJSEngine *)
{
    Q_ASSERT(&getInstance());
    QQmlEngine::setObjectOwnership(&getInstance(),QQmlEngine::CppOwnership);
    return &getInstance();
}

MyFont::MyFont(QObject *parent) : QObject(parent)
{
    iconSolid();
    iconRegular();
    qmlRegisterSingletonType<MyFont>("EUIpackage",1,0,"EFont",MyFont::provider);
}

MyFont::~MyFont()
{
    qDebug()<<__FUNCTION__;
}


