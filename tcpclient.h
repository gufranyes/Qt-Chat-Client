#ifndef TCPCLIENT_H
#define TCPCLIENT_H

#include <QObject>
#include <QTcpSocket>

class tcpClient : public QObject
{
    Q_OBJECT
public:
    explicit tcpClient(QObject *parent = nullptr);

signals:
    void newMessage(const QByteArray byteArrayMessage);
public slots:
    void connectToHost(const QString &ip, const QString &port);
    void sendMessage(const QString &message);

private slots:
    void onConnected();
    void onErrorOccurred(QAbstractSocket::SocketError error);
    void onReadyRead();

private:
    QTcpSocket _socket;
};

#endif // TCPCLIENT_H
