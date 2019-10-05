#include "time_service.h"


TimeService::TimeService(QObject *parent) : QObject(parent)
{
    // only 1 instance of timer
    if (++instances == 1) {
        if (!timer)
            timer = new MinuteTimer(QCoreApplication::instance());

        connect(timer, &MinuteTimer::timeChanged, this, &TimeService::timeChanged);
        timer->start();
    }
}

int TimeService::instances=0;
MinuteTimer *TimeService::timer=nullptr;