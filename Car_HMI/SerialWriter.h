#ifndef SERIALWRITER_H
#define SERIALWRITER_H

#include <QObject>
// #include <QWidget>
#include <QSerialPort>

class SerialWriter : public QObject
{
    Q_OBJECT
public:
    explicit SerialWriter(QObject *parent = nullptr);
    ~SerialWriter();
    Q_INVOKABLE void sendData(const QString &data);

private:
    QSerialPort *serialPort;
};

#endif // SERIALWRITER_H
