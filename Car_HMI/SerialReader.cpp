#include "SerialReader.h"
#include <QDebug>
#include <QTimer>

SerialReader::SerialReader(QObject *parent) : QObject(parent), serial(new QSerialPort(this)) {}

void SerialReader::start() {
    serial->setPortName("/dev/ttyUSB0");
    serial->setBaudRate(QSerialPort::Baud115200);

    // Thêm cấu hình quan trọng
    serial->setDataBits(QSerialPort::Data8);
    serial->setParity(QSerialPort::NoParity);
    serial->setStopBits(QSerialPort::OneStop);

    if (serial->open(QIODevice::ReadOnly)) {
        qDebug() << "Đã kết nối thành công! Port:" << serial->portName();
        qDebug() << "Cấu hình hiện tại:"
                 << serial->baudRate() << serial->dataBits()
                 << serial->parity() << serial->stopBits();

        connect(serial, &QSerialPort::readyRead, this, &SerialReader::onReadyRead);
    }
}

void SerialReader::onReadyRead() {
    buffer += QString::fromUtf8(serial->readAll());

    QByteArray data = serial->readAll();
    qDebug() << "[C++] Received raw data:" << data;

    int index;
    while ((index = buffer.indexOf('\n')) != -1) {
        QString line = buffer.left(index).trimmed();
        buffer.remove(0, index + 1);

        if (!line.isEmpty()) {
            qDebug() << "[C++] Emit:" << line;
            emit signalChanged(line);
        }
    }
}

