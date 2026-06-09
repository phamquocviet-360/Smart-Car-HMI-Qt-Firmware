#pragma once
#include <QObject>
#include <QSerialPort>

    class WifiManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool isConnected READ isConnected NOTIFY wifiStatusChanged)
    Q_PROPERTY(int btn READ btn NOTIFY dataChanged)
    Q_PROPERTY(int btn1 READ btn1 NOTIFY dataChanged)
    Q_PROPERTY(int p READ p NOTIFY dataChanged)
    Q_PROPERTY(int btn2 READ btn2 NOTIFY dataChanged)
    Q_PROPERTY(double temperature READ temperature NOTIFY dataChanged)
    Q_PROPERTY(QString ssid READ ssid NOTIFY wifiStatusChanged)


public:
    explicit WifiManager(QObject *parent = nullptr);
    ~WifiManager();

    // API gọi từ QML
    Q_INVOKABLE void requestScan();
    Q_INVOKABLE void connectWifi(const QString &ssid, const QString &password);
    Q_INVOKABLE void disconnectWifi();

    // Getter cho Q_PROPERTY
    bool isConnected() const { return m_connected; }
    int btn() const { return m_btn; }
    int btn1() const { return m_btn1; }
    int p() const { return m_p; }
    int btn2() const { return m_btn2; }
    double temperature() const { return m_temperature; }
    QString ssid() const { return m_ssid; }



signals:
    void wifiScanned(const QString &ssid, int signal, bool locked);
    void scanFinished();

    void wifiConnected(const QString &ssid, bool success);
    void wifiDisconnected();

    void log(const QString &msg);
    void wifiStatusChanged();   // phát khi trạng thái kết nối thay đổi
    void dataChanged();


private slots:
    void handleReadyRead();
    void handleError(QSerialPort::SerialPortError err);

private:
    void processLine(const QByteArray &line);

    QSerialPort *m_serial;
    QByteArray m_buffer;

    bool m_connected = false;   // đặt trong private
    int m_btn = 0;
    int m_btn1 = 0;
    int m_p = 0;
    int m_btn2 = 0;
    double m_temperature = 0.0;
    QString m_ssid;



};

