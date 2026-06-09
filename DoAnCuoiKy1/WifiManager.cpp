#include "WifiManager.h"
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QDebug>

    WifiManager::WifiManager(QObject *parent)
    : QObject(parent), m_serial(new QSerialPort(this))
{
    m_serial->setPortName("/dev/ttyUSB0");
    m_serial->setBaudRate(QSerialPort::Baud115200);

    if (!m_serial->open(QIODevice::ReadWrite)) {
        emit log("Cannot open serial");
        return;
    }

    connect(m_serial, &QSerialPort::readyRead, this, &WifiManager::handleReadyRead);
}

WifiManager::~WifiManager() {
    if (m_serial->isOpen()) m_serial->close();
}

void WifiManager::requestScan() {
    QJsonObject o{{"cmd","scan"}};
    m_serial->write(QJsonDocument(o).toJson(QJsonDocument::Compact) + '\n');
}

void WifiManager::connectWifi(const QString &ssid, const QString &password) {
    QJsonObject o;
    o["cmd"] = "connect";
    o["ssid"] = ssid;
    o["password"] = password;
    m_serial->write(QJsonDocument(o).toJson(QJsonDocument::Compact) + '\n');
}

void WifiManager::disconnectWifi() {
    QJsonObject o{{"cmd","disconnect"}};
    m_serial->write(QJsonDocument(o).toJson(QJsonDocument::Compact) + '\n');
}

void WifiManager::handleReadyRead() {
    m_buffer.append(m_serial->readAll());

    while (true) {
        int idx = m_buffer.indexOf('\n');
        if (idx < 0) break;

        QByteArray line = m_buffer.left(idx).trimmed();
        m_buffer.remove(0, idx + 1);

        if (!line.isEmpty()) processLine(line);
    }
}

void WifiManager::processLine(const QByteArray &line)
{
    if (line.startsWith("DATA:")) {
        QString data = QString::fromUtf8(line.mid(5));
        QStringList fields = data.split(";", Qt::SkipEmptyParts);

        for (QString f : fields) {
            if (f.startsWith("BTN="))
                m_btn = f.mid(4).toInt();
            else if (f.startsWith("BTN1="))
                m_btn1 = f.mid(5).toInt();
            else if (f.startsWith("BTN2="))
                m_btn2 = f.mid(5).toInt();
            else if (f.startsWith("P="))
                m_p = f.mid(2).toInt();
            else if (f.startsWith("T=")) {
                m_temperature = f.mid(2).toDouble();
                qDebug() << "Temperature updated:" << m_temperature;
            }
        }

        emit dataChanged();    //<-------------------------
        return;                //<------------------------- nên thêm return luôn
    }

    QJsonParseError err;
    QJsonDocument doc = QJsonDocument::fromJson(line, &err);
    if (err.error != QJsonParseError::NoError) return;

    QJsonObject obj = doc.object();

    // WiFi list
    if (obj.contains("wifi")) {
        QJsonArray arr = obj["wifi"].toArray();
        for (auto v : arr) {
            QJsonObject w = v.toObject();
            emit wifiScanned(w["ssid"].toString(), w["signal"].toInt(), w["locked"].toBool());
        }
        emit scanFinished();
    }

    // Connected response
    if (obj.contains("connected")) {
        bool ok = obj["connected"].toBool();
        m_connected = ok;
        m_ssid = obj["ssid"].toString();   // ⭐ LẤY TÊN WIFI
        emit wifiConnected(obj["ssid"].toString(), ok);
        emit wifiStatusChanged();
    }


    // Disconnect response
    if (obj.contains("disconnected")) {
        m_connected = false;
        m_ssid = "";                     // ⭐ RESET SSID
        emit wifiDisconnected();
        emit wifiStatusChanged();
    }

}

void WifiManager::handleError(QSerialPort::SerialPortError err) {
    Q_UNUSED(err)
}
