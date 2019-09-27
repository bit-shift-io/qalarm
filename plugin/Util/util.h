/*

https://evileg.com/en/post/263/

https://github.com/amirkogit/QtTestGround/blob/master/learn_qml/QmlCppIntegration/Take4/singletontypeexample.h

*/

#ifndef UTIL_H
#define UTIL_H

#include <QObject>
#include <QtCore>

//#include <QQmlEngine>
//#include <QJSEngine>

// some forward declarations
class QQmlEngine;
class QJSEngine;


class Util : public QObject
{
    Q_OBJECT

public:
    explicit Util(QObject *parent = 0);

    // invokable functions
    Q_INVOKABLE QString read_text_file(const QString &t_filePath);
    Q_INVOKABLE void write_text_file(const QString &t_filePath, const QString &text);
    Q_INVOKABLE bool file_exists(const QString &t_filePath) const;

signals:

public slots:

};


// Define Singleton type provider function (callback).
static QObject *util_provider(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)

    Util *util = new Util();
    return util;
}

#endif // UTIL_H
