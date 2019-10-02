#ifndef UTIL_PLUGIN_H
#define UTIL_PLUGIN_H

#include <QQmlExtensionPlugin>
#include <qqml.h>
#include "util.h"


class UtilPlugin : public QQmlExtensionPlugin
{
  Q_OBJECT
  Q_PLUGIN_METADATA(IID QQmlExtensionInterface_iid)

public:
  void registerTypes(const char *uri) override
  {
      Q_ASSERT(uri == QLatin1String("Util"));
      qmlRegisterSingletonType<Util>(uri, 1, 0, "Util", util_provider);
  }
  //void registerTypes(const char *t_uri);
};

#endif // Util_PLUGIN_H

