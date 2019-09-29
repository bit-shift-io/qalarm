/*
#include <QGuiApplication>
#include <QQmlApplicationEngine>
*/

#include <QApplication>
#include <QQmlApplicationEngine>
#include <QIcon>
#include <QQuickWidget>
#include <QSystemTrayIcon>
#include <QQmlContext>


/*
int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    // used for settings
    app.setOrganizationName("bitshift");
    app.setOrganizationDomain("bitshift.io");
    app.setApplicationName("Alarm");

    QQmlApplicationEngine engine;
    engine.addImportPath(".");
    engine.addImportPath("./lib");
    engine.addImportPath("./plugin");
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
*/

int main(int argc, char *argv[])
{
    QApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QApplication app(argc, argv);
    QQmlApplicationEngine engine;

   // used for settings
    app.setOrganizationName("bitshift");
    app.setOrganizationDomain("bitshift");
    app.setApplicationName("Alarm");

    app.setWindowIcon(QIcon("qrc:/res/bitshift.alarm.png"));

    // add imports
    engine.addImportPath(".");
    engine.addImportPath("./lib");
    engine.addImportPath("./plugin");

    // load main qml
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
