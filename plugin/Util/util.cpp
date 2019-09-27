#include "util.h"

Util::Util(QObject *parent) : QObject(parent)
{

}

/** read text file **/
QString Util::read_text_file(const QString &t_filePath)
{
    QString result;
    QFile file(t_filePath);
    if(!file.exists()) {
        qWarning() << "Does not exits: " << file;
        return result;
    }
    if(file.open(QIODevice::ReadOnly)) {
        QTextStream stream(&file);
        result = stream.readAll();
    }

    return result;
}

void Util::write_text_file(const QString &t_filePath, const QString &text)
{
    QFile file(t_filePath);
    if(file.open(QIODevice::WriteOnly)) {
        QTextStream stream(&file);
        stream << text;
    }
}

bool Util::file_exists(const QString &t_filePath) const
{
    bool result = false;
    QFile f;
    f.setFileName(t_filePath);
    if(f.exists())
    {
        result = true;
    }
    return result;
}