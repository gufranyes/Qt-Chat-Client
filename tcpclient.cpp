#include "tcpclient.h"

tcpClient::tcpClient(QObject *parent) : QObject(parent)
{
    connect(&_socket, &QTcpSocket::connected, this, &tcpClient::onConnected);
    connect(&_socket, &QTcpSocket::errorOccurred, this, &tcpClient::onErrorOccurred);
    connect(&_socket, &QTcpSocket::readyRead, this, &tcpClient::onReadyRead);
}

void tcpClient::connectToHost(const QString &ip, const QString &port){
    _socket.connectToHost(ip, port.toUInt());
}

void tcpClient::sendMessage(const QString &message)
{
    _socket.write(message.toUtf8());
    _socket.flush();
}

void tcpClient::onConnected()
{
    qInfo() << "Connected to the Host.";
}

void tcpClient::onErrorOccurred(QAbstractSocket::SocketError error)
{
    qWarning() << "Error: " << error;
}

void tcpClient::onReadyRead()
{
    const auto message = _socket.readAll();
    emit newMessage(message);
}
