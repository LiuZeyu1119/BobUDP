#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>


#include <EControl/general/EClipBoard.h>
#include <EControl/general/MyColor.h>
#include <EControl/general/MyFont.h>
#include <udpserver.h>
#include <controller.h>
#include <sendtablemodel.h>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    controller maincontrol;
    SendTableModel sendTableModel;

    engine.rootContext()->setContextProperty("sendTableModel", &sendTableModel);
    engine.addImportPath(QStringLiteral("qrc:/"));
    engine.rootContext()->setContextProperty("maincontrol", &maincontrol);
    //注册字体单例
    //字体图标查询网址 https://fontawesome.com/v5/search
    MyFont::getInstance();
    //注册颜色单例
    MyColor::getInstance();
    //注册剪切板类
    qmlRegisterType<EClipBoard>("EUIpackage",1,0,"EClipboard");

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
