#include "SerialWriter.h"
#include <QDebug>

SerialWriter::SerialWriter(QObject *parent)
    : QObject{parent}
{
    serialPort = new QSerialPort(this);

    // Mở cổng COM
    serialPort->setPortName("COM6");
    serialPort->setBaudRate(QSerialPort::Baud115200);
    serialPort->setDataBits(QSerialPort::Data8);
    serialPort->setParity(QSerialPort::NoParity);
    serialPort->setStopBits(QSerialPort::OneStop);
    serialPort->setFlowControl(QSerialPort::NoFlowControl);

    if (!serialPort->open(QIODevice::WriteOnly)) {
        qDebug() << "Không thể mở cổng serial:" << serialPort->errorString();
    } else {
        qDebug() << "Đã mở cổng serial thành công.";
    }
}

SerialWriter::~SerialWriter()
{
    if (serialPort->isOpen())
    serialPort->close();
}

void SerialWriter::sendData(const QString &data)
{
    if (serialPort->isOpen()) {
        serialPort->write(data.toUtf8());
    } else {
        qDebug() << "Cổng serial chưa mở.";
    }
}
