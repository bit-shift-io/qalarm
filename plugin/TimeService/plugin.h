#ifndef PLUGIN_H
#define PLUGIN_H

#include <QQmlExtensionPlugin>
#include <qqml.h>
#include "time_service.h"


class TimeServicePlugin : public QQmlExtensionPlugin
{
  Q_OBJECT
  Q_PLUGIN_METADATA(IID QQmlExtensionInterface_iid)

public:
  void registerTypes(const char *uri) override
  {
      Q_ASSERT(uri == QLatin1String("TimeService"));
      //qmlRegisterSingletonType<TimeService>(uri, 1, 0, "TimeService", time_service_provider);
      qmlRegisterType<TimeService>(uri, 1, 0, "TimeService");
  }
};

#endif // PLUGIN_H

