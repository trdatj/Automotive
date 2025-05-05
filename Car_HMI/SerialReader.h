#ifndef SERIALREADER_H
#define SERIALREADER_H

#include <QObject>
#include <QtSerialPort/QSerialPort>

class SerialReader : public QObject
{
    Q_OBJECT
public:
    explicit SerialReader(QObject *parent = nullptr);
    Q_INVOKABLE void start();

signals:
    void signalChanged(QString message);  // Kết nối với QML

private slots:
    void onReadyRead();

private:
    QSerialPort *serial;
    QString buffer;
};

#endif // SERIALREADER_H
