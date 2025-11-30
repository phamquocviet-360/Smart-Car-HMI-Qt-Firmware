#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "WifiManager.h"

int main(int argc, char *argv[])
{
    // ✅ BẮT BUỘC: bật Qt Virtual Keyboard
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    WifiManager wifi;
    engine.rootContext()->setContextProperty("wifiManager", &wifi);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
