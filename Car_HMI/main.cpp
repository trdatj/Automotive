#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
// #include "SerialReader.h"
// #include "SerialWriter.h"
#include "SerialManager.h"
#include <QTimer>

#define DEBUG_MODE 0

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));

    // SerialReader serial;
    // engine.rootContext()->setContextProperty("serialReader", &serial);

    // SerialWriter serialWriter;
    // engine.rootContext()->setContextProperty("serialWriter", &serialWriter);

    SerialManager serial;
    engine.rootContext()->setContextProperty("serialManager", &serial);
    serial.start();  // bắt đầu đọc

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);
    engine.load(url);

    //kiểm tra việc nhận dữ liệu
#if DEBUG_MODE
    QTimer::singleShot(1000, [&serial]() {
        qDebug() << "[C++] Gửi tín hiệu test";
        emit serial.signalChanged("LED_STATUS:ON");
    });
#endif

    return app.exec();
}
