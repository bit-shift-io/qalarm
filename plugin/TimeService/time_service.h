/*

https://evileg.com/en/post/263/

https://github.com/amirkogit/QtTestGround/blob/master/learn_qml/QmlCppIntegration/Take4/singletontypeexample.h

*/

#ifndef TIME_SERVICE_H
#define TIME_SERVICE_H

// includes
#include <QObject>
#include <QtCore>

// forward declarations
class QQmlEngine;
class QJSEngine;


class TimeService : public QObject
{
    Q_OBJECT

public:
    explicit TimeService(QObject *parent = 0);

    // invokable functions
    /*
    Q_INVOKABLE QString read_text_file(const QString &t_filePath);
    Q_INVOKABLE void write_text_file(const QString &t_filePath, const QString &text);
    Q_INVOKABLE bool file_exists(const QString &t_filePath) const;
    */

signals:

public slots:

};


// Define Singleton type provider function (callback).
static QObject *time_service_provider(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)

    TimeService *result = new TimeService();
    return result;
}

#endif // TIME_SERVICE_H
