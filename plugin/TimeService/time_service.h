/*
https://evileg.com/en/post/263/

https://github.com/amirkogit/QtTestGround/blob/master/learn_qml/QmlCppIntegration/Take4/singletontypeexample.h

// see here for examples:
https://www.qtcentre.org/threads/39317-Suggestions-on-how-to-make-an-alarmclock-like-function
*/

#ifndef TIME_SERVICE_H
#define TIME_SERVICE_H

// includes
#include <QObject>
#include <QtCore>
#include "minute_timer.h"

class TimeService : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int hour READ hour NOTIFY timeChanged)
    Q_PROPERTY(int minute READ minute NOTIFY timeChanged)
//![0]

public:
    explicit TimeService(QObject *parent = 0);

    ~TimeService() override
    {
        if (--instances == 0) {
            timer->stop();
        }
    }

    int minute() const { return timer->minute(); }
    int hour() const { return timer->hour(); }

signals:
    void timeChanged();

private:
    QTime t;
    static MinuteTimer *timer;
    static int instances;
};


#endif // TIME_SERVICE_H
